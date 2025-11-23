import sys
from functools import lru_cache

sys.setrecursionlimit(2000)

MOD = 10**9 + 7
MAX_N = 1001  # Max length of nums is 1000, so max n for C(n,k) is 999.

fact = [1] * MAX_N
inv_fact = [1] * MAX_N

for i in range(1, MAX_N):
    fact[i] = (fact[i-1] * i) % MOD

inv_fact[MAX_N - 1] = pow(fact[MAX_N - 1], MOD - 2, MOD)  # Fermat's Little Theorem for modular inverse
for i in range(MAX_N - 2, -1, -1):
    inv_fact[i] = (inv_fact[i+1] * (i+1)) % MOD

def get_combinations(n, k):
    if k < 0 or k > n:
        return 0
    return (fact[n] * inv_fact[k] % MOD * inv_fact[n-k] % MOD) % MOD

class Solution:
    def numOfWays(self, nums: list[int]) -> int:

        @lru_cache(None)
        def solve(arr_tuple: tuple[int, ...]) -> int:
            n = len(arr_tuple)
            if n <= 1:
                return 1

            root = arr_tuple[0]
            left_subtree_elements = []
            right_subtree_elements = []

            for x in arr_tuple[1:]:
                if x < root:
                    left_subtree_elements.append(x)
                else:
                    right_subtree_elements.append(x)

            num_left = len(left_subtree_elements)
            num_right = len(right_subtree_elements)

            ways_left = solve(tuple(left_subtree_elements))
            ways_right = solve(tuple(right_subtree_elements))

            # The number of ways to interleave the elements of the left and right subtrees
            # into the (n-1) available slots after the root.
            # This is equivalent to choosing num_left slots out of (num_left + num_right) total slots
            # for the left subtree elements (the right subtree elements fill the rest).
            combinations = get_combinations(num_left + num_right, num_left)

            result = (combinations * ways_left % MOD * ways_right % MOD) % MOD
            return result

        # The problem asks for the number of ways to reorder *excluding* the original order.
        # So we subtract 1 from the total count.
        # Add MOD before taking modulo to handle potential negative result from subtraction.
        return (solve(tuple(nums)) - 1 + MOD) % MOD
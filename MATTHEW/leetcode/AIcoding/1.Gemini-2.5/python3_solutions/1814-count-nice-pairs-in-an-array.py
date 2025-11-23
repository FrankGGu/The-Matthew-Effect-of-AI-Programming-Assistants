import collections

class Solution:
    def countNicePairs(self, nums: list[int]) -> int:
        MOD = 10**9 + 7

        def rev(n: int) -> int:
            reversed_n = 0
            temp_n = n
            while temp_n > 0:
                digit = temp_n % 10
                reversed_n = reversed_n * 10 + digit
                temp_n //= 10
            return reversed_n

        diff_counts = collections.defaultdict(int)
        nice_pairs_count = 0

        for num in nums:
            current_diff = num - rev(num)

            nice_pairs_count = (nice_pairs_count + diff_counts[current_diff]) % MOD

            diff_counts[current_diff] += 1

        return nice_pairs_count
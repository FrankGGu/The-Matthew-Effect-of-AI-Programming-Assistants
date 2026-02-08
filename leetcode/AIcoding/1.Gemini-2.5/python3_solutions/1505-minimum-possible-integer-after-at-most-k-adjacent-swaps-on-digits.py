from collections import deque

class FenwickTree:
    def __init__(self, size):
        self.tree = [0] * (size + 1)
        self.size = size

    def update(self, idx, delta):
        # Fenwick tree is 1-indexed internally, so convert 0-indexed idx
        idx += 1
        while idx <= self.size:
            self.tree[idx] += delta
            idx += idx & (-idx)

    def query(self, idx):
        # Fenwick tree is 1-indexed internally, so convert 0-indexed idx
        # Query sum from 0 to idx (inclusive)
        if idx < 0:
            return 0
        idx += 1
        s = 0
        while idx > 0:
            s += self.tree[idx]
            idx -= idx & (-idx)
        return s

class Solution:
    def minInteger(self, num: str, k: int) -> str:
        n = len(num)

        # Stores original indices of each digit in a deque for O(1) popleft
        pos = [deque() for _ in range(10)]
        for i in range(n):
            pos[int(num[i])].append(i)

        # Fenwick tree to keep track of available positions.
        # Initially all positions are available (value 1).
        ft = FenwickTree(n)
        for i in range(n):
            ft.update(i, 1)

        ans = []
        for i in range(n): # i is the current target position (0-indexed) in the final string
            for d in range(10): # Try digits 0-9 to find the smallest possible
                if pos[d]: # If digit 'd' is still available
                    original_idx = pos[d][0] # Get the first (leftmost) occurrence of digit 'd'

                    # Calculate current effective position (0-indexed) of original_idx
                    # among the available elements.
                    # ft.query(original_idx) gives the count of available elements up to original_idx (inclusive).
                    # So, ft.query(original_idx) - 1 is its 0-indexed rank among available elements.
                    current_effective_idx = ft.query(original_idx) - 1

                    # Cost is the number of swaps needed to bring this digit to the current target position 'i'.
                    # This is the difference between its current effective position and the target position 'i'.
                    # If current_effective_idx < i, it means the digit is already "to the left" of the target slot 'i'
                    # among the available digits. This implies 0 swaps are needed to bring it to this slot
                    # relative to other available digits, as we are filling 'ans' from left to right.
                    cost = max(0, current_effective_idx - i)

                    if cost <= k:
                        ans.append(str(d))
                        k -= cost
                        pos[d].popleft()
                        ft.update(original_idx, -1) # Mark this original_idx as used in the Fenwick tree
                        break # Found the digit for current position 'i', move to the next position

        return "".join(ans)
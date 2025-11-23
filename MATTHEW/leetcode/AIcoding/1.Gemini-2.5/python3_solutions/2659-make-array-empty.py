class FenwickTree:
    def __init__(self, n):
        self.n = n
        self.tree = [0] * (n + 1)

    def update(self, idx, val):
        # idx is 0-indexed, convert to 1-indexed
        idx += 1
        while idx <= self.n:
            self.tree[idx] += val
            idx += idx & (-idx)

    def query(self, idx):
        # idx is 0-indexed, convert to 1-indexed
        # If idx is -1, idx+1 becomes 0, loop won't run, returns 0.
        idx += 1
        res = 0
        while idx > 0:
            res += self.tree[idx]
            idx -= idx & (-idx)
        return res

class Solution:
    def makeArrayEmpty(self, nums: list[int]) -> int:
        n = len(nums)

        # Store (value, original_index) pairs
        indexed_nums = []
        for i in range(n):
            indexed_nums.append((nums[i], i))

        # Sort by value to process elements in increasing order
        indexed_nums.sort()

        # Initialize Fenwick Tree
        # All elements are initially present, so set count to 1 for each index
        ft = FenwickTree(n)
        for i in range(n):
            ft.update(i, 1)

        total_operations = 0
        current_pointer = 0 # This tracks the effective start of the array (0-indexed original index)

        for _, original_idx in indexed_nums:
            # Calculate operations to reach original_idx from current_pointer

            if original_idx >= current_pointer:
                # No wrap-around needed.
                # Count elements from current_pointer to original_idx (inclusive).
                count = ft.query(original_idx) - ft.query(current_pointer - 1)
                total_operations += count
            else:
                # Wrap-around needed.
                # Count elements from current_pointer to n-1, then from 0 to original_idx.
                count = (ft.query(n - 1) - ft.query(current_pointer - 1)) + ft.query(original_idx)
                total_operations += count

            # Mark the element at original_idx as removed in the Fenwick Tree
            ft.update(original_idx, -1)

            # Update current_pointer to the element immediately after the removed one.
            # This simulates the rotation.
            current_pointer = (original_idx + 1) % n

        return total_operations
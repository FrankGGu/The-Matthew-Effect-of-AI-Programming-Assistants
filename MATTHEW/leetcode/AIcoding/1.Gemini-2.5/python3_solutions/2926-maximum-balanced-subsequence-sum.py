import collections

class SegmentTree:
    def __init__(self, size):
        self.size = size
        # Initialize with negative infinity to correctly find maximums,
        # especially when all numbers are negative or no valid previous subsequence exists.
        self.tree = [-float('inf')] * (4 * size) 

    def update(self, node, start, end, idx, val):
        # Base case: leaf node
        if start == end:
            # If multiple updates map to the same coordinate, store the maximum sum
            self.tree[node] = max(self.tree[node], val) 
            return

        mid = (start + end) // 2
        # Recurse based on whether idx is in the left or right child's range
        if start <= idx <= mid:
            self.update(2 * node, start, mid, idx, val)
        else:
            self.update(2 * node + 1, mid + 1, end, idx, val)

        # Update parent node with the maximum of its children
        self.tree[node] = max(self.tree[2 * node], self.tree[2 * node + 1])

    def query(self, node, start, end, l, r):
        # If the current node's range is outside the query range, return negative infinity
        if r < start or end < l: 
            return -float('inf')

        # If the current node's range is completely within the query range, return its value
        if l <= start and end <= r: 
            return self.tree[node]

        # Otherwise, query children and return the maximum
        mid = (start + end) // 2
        p1 = self.query(2 * node, start, mid, l, r)
        p2 = self.query(2 * node + 1, mid + 1, end, l, r)
        return max(p1, p2)

class Solution:
    def maxBalancedSubsequenceSum(self, nums: list[int]) -> int:
        n = len(nums)
        if n == 0:
            return 0

        # Step 1: Collect all (nums[i] + i) values for coordinate compression
        all_vals_plus_idx = []
        for i in range(n):
            all_vals_plus_idx.append(nums[i] + i)

        # Step 2: Create a sorted unique list of these values
        coords = sorted(list(set(all_vals_plus_idx)))

        # Step 3: Create a mapping from value to its compressed index
        val_to_idx = {val: i for i, val in enumerate(coords)}

        # Step 4: Initialize the Segment Tree
        seg_tree_size = len(coords)
        seg_tree = SegmentTree(seg_tree_size)

        # Step 5: Initialize the overall maximum sum
        max_overall_sum = -float('inf')

        # Step 6: Iterate through the numbers to build the DP solution
        for i in range(n):
            target_val = nums[i] + i
            compressed_idx = val_to_idx[target_val]

            # Query the segment tree for the maximum sum of a balanced subsequence
            # ending at some j < i such that nums[j] + j <= nums[i] + i.
            # This corresponds to querying the range [0, compressed_idx] in the segment tree.
            prev_max_dp = seg_tree.query(1, 0, seg_tree_size - 1, 0, compressed_idx)

            # Calculate the current subsequence sum ending at index i
            current_dp = nums[i]
            if prev_max_dp != -float('inf'): # If a valid previous subsequence was found
                current_dp += prev_max_dp

            # Update the segment tree at the current compressed_idx with current_dp.
            # We take the maximum because multiple (nums[k]+k) can map to the same compressed_idx,
            # and we want to store the largest possible sum ending there.
            seg_tree.update(1, 0, seg_tree_size - 1, compressed_idx, current_dp)

            # Update the overall maximum sum found so far
            max_overall_sum = max(max_overall_sum, current_dp)

        # Step 7: Return the maximum balanced subsequence sum
        return max_overall_sum
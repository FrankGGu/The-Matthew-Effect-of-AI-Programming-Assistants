class SegmentTree:
    def __init__(self, size):
        self.size = size
        # Initialize with 0s, as we are looking for maximum length
        # A length of 0 means no such subsequence exists.
        self.tree = [0] * (4 * size) 

    def update(self, node, start, end, idx, val):
        # Base case: Leaf node, update its value
        if start == end:
            self.tree[node] = max(self.tree[node], val)
            return

        mid = (start + end) // 2
        # Decide which child to recurse on
        if start <= idx <= mid:
            self.update(2 * node, start, mid, idx, val)
        else:
            self.update(2 * node + 1, mid + 1, end, idx, val)

        # Update current node's value based on its children
        self.tree[node] = max(self.tree[2 * node], self.tree[2 * node + 1])

    def query(self, node, start, end, l, r):
        # Case 1: Current node's range is completely outside the query range [l, r]
        if r < start or end < l:
            return 0
        # Case 2: Current node's range is completely inside the query range [l, r]
        if l <= start and end <= r:
            return self.tree[node]

        # Case 3: Current node's range partially overlaps with query range
        mid = (start + end) // 2
        p1 = self.query(2 * node, start, mid, l, r)
        p2 = self.query(2 * node + 1, mid + 1, end, l, r)
        return max(p1, p2)

class Solution:
    def longestSubsequence(self, nums: list[int], k: int) -> int:
        # The maximum possible value for nums[i] is 10^5.
        # The segment tree will operate on indices from 1 to MAX_VAL.
        MAX_VAL = 100000 

        # Initialize a segment tree to store the maximum LIS length ending at a particular value.
        # The segment tree is 1-indexed for values, so its range will be [1, MAX_VAL].
        seg_tree = SegmentTree(MAX_VAL)

        max_lis_len = 0

        for num in nums:
            # For the current number 'num', we need to find the longest increasing subsequence
            # ending at a 'prev_num' such that 'num - k <= prev_num < num'.
            # The range for 'prev_num' is [max(1, num - k), num - 1].
            query_start = max(1, num - k)
            query_end = num - 1

            # The current number 'num' itself forms an LIS of length 1.
            current_lis_len = 1 

            # If there's a valid range for previous elements (query_start <= query_end),
            # query the segment tree for the maximum LIS length in that range.
            if query_start <= query_end:
                prev_max_len = seg_tree.query(1, 1, MAX_VAL, query_start, query_end)
                current_lis_len += prev_max_len

            # Update the segment tree: for 'num', the longest increasing subsequence
            # ending at 'num' has length 'current_lis_len'.
            # We use max because 'num' might appear multiple times or be part of different subsequences.
            seg_tree.update(1, 1, MAX_VAL, num, current_lis_len)

            # Keep track of the overall maximum LIS length found so far.
            max_lis_len = max(max_lis_len, current_lis_len)

        return max_lis_len
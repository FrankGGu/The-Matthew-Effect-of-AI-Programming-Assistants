from typing import List

class SegTreeNode:
    def __init__(self):
        self.sum0 = 0  # sum of nums2[i] where nums1[i] is 0
        self.sum1 = 0  # sum of nums2[i] where nums1[i] is 1
        self.lazy_flip = False

class SegmentTree:
    def __init__(self, nums1: List[int], nums2: List[int]):
        self.n = len(nums1)
        self.nums1 = nums1  # Keep a reference to nums1 to update its values
        self.nums2 = nums2
        self.tree = [SegTreeNode() for _ in range(4 * self.n)]
        self.build(1, 0, self.n - 1)

    def build(self, node_idx: int, start: int, end: int):
        if start == end:
            if self.nums1[start] == 0:
                self.tree[node_idx].sum0 = self.nums2[start]
            else:
                self.tree[node_idx].sum1 = self.nums2[start]
            return

        mid = (start + end) // 2
        self.build(2 * node_idx, start, mid)
        self.build(2 * node_idx + 1, mid + 1, end)
        self.tree[node_idx].sum0 = self.tree[2 * node_idx].sum0 + self.tree[2 * node_idx + 1].sum0
        self.tree[node_idx].sum1 = self.tree[2 * node_idx].sum1 + self.tree[2 * node_idx + 1].sum1

    def push_down(self, node_idx: int):
        if self.tree[node_idx].lazy_flip:
            # Swap sum0 and sum1 for children
            self.tree[2 * node_idx].sum0, self.tree[2 * node_idx].sum1 = \
                self.tree[2 * node_idx].sum1, self.tree[2 * node_idx].sum0
            self.tree[2 * node_idx + 1].sum0, self.tree[2 * node_idx + 1].sum1 = \
                self.tree[2 * node_idx + 1].sum1, self.tree[2 * node_idx + 1].sum0

            # Toggle lazy_flip for children
            self.tree[2 * node_idx].lazy_flip = not self.tree[2 * node_idx].lazy_flip
            self.tree[2 * node_idx + 1].lazy_flip = not self.tree[2 * node_idx + 1].lazy_flip

            # Reset lazy_flip for current node
            self.tree[node_idx].lazy_flip = False

    def pull_up(self, node_idx: int):
        self.tree[node_idx].sum0 = self.tree[2 * node_idx].sum0 + self.tree[2 * node_idx + 1].sum0
        self.tree[node_idx].sum1 = self.tree[2 * node_idx].sum1 + self.tree[2 * node_idx + 1].sum1

    def update_point(self, node_idx: int, start: int, end: int, idx: int, new_val_nums1: int) -> int:
        # Returns the change in the total sum S

        if start == end: # Leaf node
            old_val_nums1 = 1 if self.tree[node_idx].sum1 > 0 else 0
            change_in_S = 0
            if old_val_nums1 == 0 and new_val_nums1 == 1:
                self.tree[node_idx].sum0 -= self.nums2[idx]
                self.tree[node_idx].sum1 += self.nums2[idx]
                change_in_S = self.nums2[idx]
            elif old_val_nums1 == 1 and new_val_nums1 == 0:
                self.tree[node_idx].sum0 += self.nums2[idx]
                self.tree[node_idx].sum1 -= self.nums2[idx]
                change_in_S = -self.nums2[idx]
            self.nums1[idx] = new_val_nums1 # Update the actual nums1 array
            return change_in_S

        self.push_down(node_idx) # Push down lazy flag before recursing
        mid = (start + end) // 2
        change_in_S = 0
        if idx <= mid:
            change_in_S = self.update_point(2 * node_idx, start, mid, idx, new_val_nums1)
        else:
            change_in_S = self.update_point(2 * node_idx + 1, mid + 1, end, idx, new_val_nums1)

        self.pull_up(node_idx) # Recalculate sums for current node
        return change_in_S

    def update_range_flip(self, node_idx: int, start: int, end: int, query_l: int, query_r: int) -> int:
        # Returns the change in the total sum S

        if query_l > end or query_r < start: # No overlap
            return 0

        if query_l <= start and end <= query_r: # Complete overlap
            change_in_S = self.tree[node_idx].sum0 - self.tree[node_idx].sum1
            self.tree[node_idx].sum0, self.tree[node_idx].sum1 = \
                self.tree[node_idx].sum1, self.tree[node_idx].sum0
            self.tree[node_idx].lazy_flip = not self.tree[node_idx].lazy_flip
            return change_in_S

        self.push_down(node_idx) # Push down lazy flag before recursing
        mid = (start + end) // 2
        change_left = self.update_range_flip(2 * node_idx, start, mid, query_l, query_r)
        change_right = self.update_range_flip(2 * node_idx + 1, mid + 1, end, query_l, query_r)

        self.pull_up(node_idx) # Recalculate sums for current node
        return change_left + change_right

class Solution:
    def handleQuery(self, nums1: List[int], nums2: List[int], queries: List[List[int]]) -> List[int]:
        n = len(nums1)

        # Initialize current_total_sum
        current_total_sum = 0
        for i in range(n):
            current_total_sum += nums1[i] * nums2[i]

        # Initialize Segment Tree
        seg_tree = SegmentTree(nums1, nums2)

        results = []
        for query in queries:
            type = query[0]
            if type == 0:
                idx, val = query[1], query[2]
                change = seg_tree.update_point(1, 0, n - 1, idx, val)
                current_total_sum += change
            elif type == 1:
                l, r = query[1], query[2]
                change = seg_tree.update_range_flip(1, 0, n - 1, l, r)
                current_total_sum += change
            else: # type == 2
                results.append(current_total_sum)

        return results
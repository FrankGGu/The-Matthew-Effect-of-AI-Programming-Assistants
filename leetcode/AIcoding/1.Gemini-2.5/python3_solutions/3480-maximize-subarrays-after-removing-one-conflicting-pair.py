import collections
import bisect

class SegmentTree:
    def __init__(self, size):
        self.size = size
        self.tree = [0] * (4 * size)

    def _update(self, node, start, end, idx, val):
        if start == end:
            self.tree[node] = max(self.tree[node], val)
            return

        mid = (start + end) // 2
        if start <= idx <= mid:
            self._update(2 * node, start, mid, idx, val)
        else:
            self._update(2 * node + 1, mid + 1, end, idx, val)

        self.tree[node] = max(self.tree[2 * node], self.tree[2 * node + 1])

    def update(self, idx, val):
        self._update(1, 0, self.size - 1, idx, val)

    def _query(self, node, start, end, l, r):
        if r < start or end < l or l > r:
            return 0

        if l <= start and end <= r:
            return self.tree[node]

        mid = (start + end) // 2
        p1 = self._query(2 * node, start, mid, l, r)
        p2 = self._query(2 * node + 1, mid + 1, end, l, r)
        return max(p1, p2)

    def query(self, l, r):
        if l > r:
            return 0
        return self._query(1, 0, self.size - 1, l, r)

class Solution:
    def maximizeTheNumberOfSubarrays(self, intervals: list[list[int]]) -> int:
        n = len(intervals)
        if n == 0:
            return 0

        all_coords = set()
        for s, e in intervals:
            all_coords.add(s)
            all_coords.add(e)

        sorted_coords = sorted(list(all_coords))
        coord_to_idx = {val: i for i, val in enumerate(sorted_coords)}
        M = len(sorted_coords)

        intervals.sort(key=lambda x: (x[0], x[1]))

        # max_non_overlap_val[k] = max non-overlapping intervals chosen from intervals[0...k-1]
        # This is the max non-overlapping count considering intervals *before* index k.
        max_non_overlap_val = [0] * (n + 1)
        seg_tree_no_conflict_calc = SegmentTree(M)

        for k in range(n):
            s_k, e_k = intervals[k]
            mapped_s_k = coord_to_idx[s_k]
            mapped_e_k = coord_to_idx[e_k]

            prev_max = seg_tree_no_conflict_calc.query(0, mapped_s_k - 1)
            current_count = prev_max + 1

            seg_tree_no_conflict_calc.update(mapped_e_k, current_count)

            max_non_overlap_val[k+1] = max(max_non_overlap_val[k], current_count)

        dp0 = [0] * n
        dp1 = [0] * n

        seg_tree_dp0 = SegmentTree(M)
        seg_tree_dp1 = SegmentTree(M)
        seg_tree_conflict_candidates = SegmentTree(M) 

        ans = 0

        for i in range(n):
            s_i, e_i = intervals[i]
            mapped_s_i = coord_to_idx[s_i]
            mapped_e_i = coord_to_idx[e_i]

            # Calculate dp0[i]: max non-overlapping ending with intervals[i]
            prev_max_dp0 = seg_tree_dp0.query(0, mapped_s_i - 1)
            dp0[i] = 1 + prev_max_dp0

            # Calculate dp1[i]: max with one conflict ending with intervals[i]
            # Case 1: intervals[i] extends a sequence that already had one conflict.
            prev_max_dp1 = seg_tree_dp1.query(0, mapped_s_i - 1)
            val_case1 = 1 + prev_max_dp1

            # Case 2: intervals[i] forms a *new* conflict with some intervals[j] (j < i)
            # For this, intervals[j] must overlap with intervals[i] (intervals[j][1] >= s_i).
            # The total count is 2 (for intervals[i] and intervals[j]) + max non-overlapping intervals before intervals[j].
            # max non-overlapping intervals before intervals[j] is max_non_overlap_val[j].
            # We query seg_tree_conflict_candidates for max(max_non_overlap_val[j])
            # where intervals[j][1] >= s_i.
            max_val_for_conflict = seg_tree_conflict_candidates.query(mapped_s_i, M - 1)
            val_case2 = 2 + max_val_for_conflict

            dp1[i] = max(val_case1, val_case2)

            ans = max(ans, dp0[i], dp1[i])

            seg_tree_dp0.update(mapped_e_i, dp0[i])
            seg_tree_dp1.update(mapped_e_i, dp1[i])
            # Update seg_tree_conflict_candidates with max_non_overlap_val[i]
            # max_non_overlap_val[i] is the max non-overlapping count from intervals[0...i-1].
            # This is correct for when intervals[i] acts as the 'j' interval in a future conflict.
            seg_tree_conflict_candidates.update(mapped_e_i, max_non_overlap_val[i])

        return ans
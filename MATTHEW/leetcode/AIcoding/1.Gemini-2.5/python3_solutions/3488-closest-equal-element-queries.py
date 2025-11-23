import collections
import math

class SegmentTree:
    def __init__(self, n):
        self.n = n
        self.tree = [math.inf] * (4 * n)

    def _update_recursive(self, node, start, end, idx, val):
        if start == end:
            self.tree[node] = min(self.tree[node], val)
            return

        mid = (start + end) // 2
        if start <= idx <= mid:
            self._update_recursive(2 * node, start, mid, idx, val)
        else:
            self._update_recursive(2 * node + 1, mid + 1, end, idx, val)
        self.tree[node] = min(self.tree[2 * node], self.tree[2 * node + 1])

    def update(self, idx, val):
        self._update_recursive(1, 0, self.n - 1, idx, val)

    def _query_recursive(self, node, start, end, l, r):
        if r < start or end < l:
            return math.inf
        if l <= start and end <= r:
            return self.tree[node]

        mid = (start + end) // 2
        p1 = self._query_recursive(2 * node, start, mid, l, r)
        p2 = self._query_recursive(2 * node + 1, mid + 1, end, l, r)
        return min(p1, p2)

    def query(self, l, r):
        if l > r:
            return math.inf
        return self._query_recursive(1, 0, self.n - 1, l, r)

class Solution:
    def closestEqualElementQueries(self, nums: list[int], queries: list[list[int]]) -> list[int]:
        n = len(nums)
        q_count = len(queries)

        ans = [-1] * q_count

        queries_at_right = collections.defaultdict(list)
        for i, (left, right) in enumerate(queries):
            queries_at_right[right].append((left, i))

        seg_tree = SegmentTree(n)

        last_occurrence = {}

        for i in range(n):
            num = nums[i]

            if num in last_occurrence:
                prev_idx = last_occurrence[num]
                seg_tree.update(prev_idx, i - prev_idx)

            last_occurrence[num] = i

            if i in queries_at_right:
                for left, query_idx in queries_at_right[i]:
                    min_dist = seg_tree.query(left, i - 1)

                    if min_dist != math.inf:
                        ans[query_idx] = min_dist

        return ans
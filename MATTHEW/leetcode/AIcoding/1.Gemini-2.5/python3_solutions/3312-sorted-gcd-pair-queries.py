import math

class SegmentTree:
    def __init__(self, n):
        self.n = n
        self.tree = [0] * (4 * n) # Stores max value

    def _update(self, idx, val, node, start, end):
        if start == end:
            self.tree[node] = max(self.tree[node], val)
            return
        mid = (start + end) // 2
        if start <= idx <= mid:
            self._update(idx, val, 2 * node, start, mid)
        else:
            self._update(idx, val, 2 * node + 1, mid + 1, end)
        self.tree[node] = max(self.tree[2 * node], self.tree[2 * node + 1])

    def _query(self, l, r, node, start, end):
        if r < start or end < l:
            return 0 # No overlap
        if l <= start and end <= r:
            return self.tree[node] # Complete overlap
        mid = (start + end) // 2
        p1 = self._query(l, r, 2 * node, start, mid)
        p2 = self._query(l, r, 2 * node + 1, mid + 1, end)
        return max(p1, p2)

    def point_update(self, idx, val):
        self._update(idx, val, 1, 0, self.n - 1)

    def range_query(self, l, r):
        if l > r: return 0 # No valid range
        return self._query(l, r, 1, 0, self.n - 1)

class Solution:
    def solve(self, nums: list[int], queries: list[list[int]]) -> list[int]:
        n = len(nums)

        max_val = 0
        if n > 0:
            max_val = max(nums)

        last_seen_multiple = [-1] * (max_val + 1)

        queries_by_R = [[] for _ in range(n)]
        for q_idx, (L, R) in enumerate(queries):
            queries_by_R[R].append((L, q_idx))

        ans = [0] * len(queries)

        seg_tree = SegmentTree(n)

        for i in range(n):
            x = nums[i]

            divs = []
            for d_candidate in range(1, int(math.sqrt(x)) + 1):
                if x % d_candidate == 0:
                    divs.append(d_candidate)
                    if d_candidate * d_candidate != x:
                        divs.append(x // d_candidate)

            for d in divs:
                if last_seen_multiple[d] != -1:
                    seg_tree.point_update(last_seen_multiple[d], d)
                last_seen_multiple[d] = i

            for L, q_idx in queries_by_R[i]:
                ans[q_idx] = seg_tree.range_query(L, i - 1)

        return ans
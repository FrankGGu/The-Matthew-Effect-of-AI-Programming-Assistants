class Solution:
    def maximumSumQueries(self, nums1: List[int], nums2: List[int], queries: List[List[int]]) -> List[int]:
        import bisect

        pairs = sorted([(a, b) for a, b in zip(nums1, nums2)], reverse=True)
        queries = sorted([(x, y, i) for i, (x, y) in enumerate(queries)], reverse=True)

        res = [-1] * len(queries)
        stack = []
        ptr = 0

        for x, y, idx in queries:
            while ptr < len(pairs) and pairs[ptr][0] >= x:
                a, b = pairs[ptr]
                while stack and stack[-1][1] <= a + b:
                    stack.pop()
                if not stack or stack[-1][0] < b:
                    stack.append((b, a + b))
                ptr += 1

            pos = bisect.bisect_left(stack, (y, -1))
            if pos < len(stack):
                res[idx] = stack[pos][1]

        return res
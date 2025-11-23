class Solution:
    def minimumAbsDiff(self, arr: List[int], queries: List[List[int]]) -> List[int]:
        arr.sort()
        res = []
        for q in queries:
            l, r = q
            min_diff = float('inf')
            for i in range(l, r):
                diff = arr[i + 1] - arr[i]
                if diff < min_diff:
                    min_diff = diff
            res.append(min_diff)
        return res
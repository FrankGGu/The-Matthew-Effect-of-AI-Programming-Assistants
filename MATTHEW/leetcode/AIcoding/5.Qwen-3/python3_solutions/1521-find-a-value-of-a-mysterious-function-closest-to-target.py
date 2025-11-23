class Solution:
    def closestToTarget(self, A: List[int], target: int) -> int:
        s = {A[0]}
        res = abs(A[0] - target)
        for i in range(1, len(A)):
            t = set()
            t.add(A[i])
            for x in s:
                t.add(x & A[i])
            s = t
            for x in s:
                res = min(res, abs(x - target))
        return res
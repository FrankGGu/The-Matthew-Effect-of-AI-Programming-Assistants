class Solution:
    def customSortString(self, S: str, T: str) -> str:
        count = {}
        for c in T:
            count[c] = count.get(c, 0) + 1
        res = []
        for c in S:
            if c in count:
                res.append(c * count[c])
                del count[c]
        for c in count:
            res.append(c * count[c])
        return ''.join(res)
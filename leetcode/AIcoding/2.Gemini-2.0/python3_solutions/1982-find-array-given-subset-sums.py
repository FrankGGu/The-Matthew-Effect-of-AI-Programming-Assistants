class Solution:
    def recoverArray(self, n: int, sums: List[int]) -> List[int]:
        sums.sort()
        res = []
        while len(sums) > 1:
            diff = sums[1] - sums[0]
            pos = []
            neg = []
            seen = set()
            for s in sums:
                if s in seen:
                    neg.append(s)
                else:
                    pos.append(s)
                    seen.add(s + diff)
            if len(pos) < len(neg):
                res.append(-diff)
                sums = pos
            else:
                res.append(diff)
                sums = neg
        return res
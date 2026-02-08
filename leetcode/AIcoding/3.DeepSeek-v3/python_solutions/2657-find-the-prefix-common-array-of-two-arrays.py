class Solution:
    def findThePrefixCommonArray(self, A: List[int], B: List[int]) -> List[int]:
        common = set()
        res = []
        count = 0
        for a, b in zip(A, B):
            if a in common:
                count += 1
            else:
                common.add(a)
            if b in common:
                count += 1
            else:
                common.add(b)
            res.append(count)
        return res
class Solution:
    def prefixesDivBy5(self, A: List[int]) -> List[bool]:
        res = []
        num = 0
        for a in A:
            num = (num * 2 + a) % 5
            res.append(num == 0)
        return res
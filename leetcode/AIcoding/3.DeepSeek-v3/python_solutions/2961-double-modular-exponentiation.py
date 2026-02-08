class Solution:
    def getGoodIndices(self, variables: List[List[int]], target: int) -> List[int]:
        res = []
        for idx, (a, b, c, m) in enumerate(variables):
            x = pow(a, b, 10)
            y = pow(x, c, m)
            if y == target:
                res.append(idx)
        return res
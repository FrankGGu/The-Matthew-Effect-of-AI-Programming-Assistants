class Solution:
    def getGoodIndices(self, variables: List[List[int]], target: int) -> List[int]:
        res = []
        for i, var in enumerate(variables):
            a, b, c, m = var
            val = pow(a, b, 10)
            val = pow(val, c, m)
            if val == target:
                res.append(i)
        return res
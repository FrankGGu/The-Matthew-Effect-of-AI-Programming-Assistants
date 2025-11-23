class Solution:
    def numEquivDominoPairs(self, dominoes: List[List[int]]) -> int:
        count = {}
        res = 0
        for a, b in dominoes:
            key = (min(a, b), max(a, b))
            res += count.get(key, 0)
            count[key] = count.get(key, 0) + 1
        return res
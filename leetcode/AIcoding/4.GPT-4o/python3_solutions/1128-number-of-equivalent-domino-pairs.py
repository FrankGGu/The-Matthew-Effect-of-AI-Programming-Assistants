class Solution:
    def numEquivDominoPairs(self, dominoes: List[List[int]]) -> int:
        count = defaultdict(int)
        for a, b in dominoes:
            count[tuple(sorted((a, b)))] += 1
        return sum(v * (v - 1) // 2 for v in count.values())
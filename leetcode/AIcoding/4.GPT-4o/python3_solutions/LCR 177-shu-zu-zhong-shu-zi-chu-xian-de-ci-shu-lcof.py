class Solution:
    def colorCombinations(self, colors: List[str]) -> List[str]:
        from itertools import combinations
        result = set()
        for r in range(1, len(colors) + 1):
            for combo in combinations(colors, r):
                result.add(''.join(sorted(combo)))
        return sorted(result)
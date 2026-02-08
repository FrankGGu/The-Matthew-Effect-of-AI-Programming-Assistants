from itertools import combinations

class Solution:
    def distinctNames(self, ideas: List[str]) -> int:
        prefixes = defaultdict(set)
        for idea in ideas:
            prefixes[idea[0]].add(idea[1:])

        count = 0
        for a, b in combinations(prefixes.keys(), 2):
            count += len(prefixes[a]) * len(prefixes[b] - prefixes[a]) + len(prefixes[b]) * len(prefixes[a] - prefixes[b])

        return count
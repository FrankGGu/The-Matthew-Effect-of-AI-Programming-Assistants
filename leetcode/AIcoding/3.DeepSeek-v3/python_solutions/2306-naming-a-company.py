class Solution:
    def distinctNames(self, ideas: List[str]) -> int:
        # Group ideas by their first letter
        groups = defaultdict(set)
        for idea in ideas:
            groups[idea[0]].add(idea[1:])

        res = 0
        # Compare all pairs of groups
        for a in groups:
            for b in groups:
                if a == b:
                    continue
                # Find the number of common suffixes
                common = len(groups[a] & groups[b])
                res += (len(groups[a]) - common) * (len(groups[b]) - common)
        return res
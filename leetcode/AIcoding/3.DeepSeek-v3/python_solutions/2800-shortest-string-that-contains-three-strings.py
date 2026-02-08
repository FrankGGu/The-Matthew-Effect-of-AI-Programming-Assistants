class Solution:
    def minimumString(self, a: str, b: str, c: str) -> str:
        def combine(s1, s2):
            if s2 in s1:
                return s1
            for i in range(min(len(s1), len(s2)), -1, -1):
                if s1.endswith(s2[:i]):
                    return s1 + s2[i:]
            return s1 + s2

        candidates = []
        # Generate all possible combinations of merging the three strings in different orders
        for order in [
            [a, b, c],
            [a, c, b],
            [b, a, c],
            [b, c, a],
            [c, a, b],
            [c, b, a]
        ]:
            merged = combine(combine(order[0], order[1]), order[2])
            candidates.append(merged)

        # Find the shortest string, if multiple, return lex smallest
        min_len = min(len(s) for s in candidates)
        shortest = [s for s in candidates if len(s) == min_len]
        shortest.sort()
        return shortest[0]
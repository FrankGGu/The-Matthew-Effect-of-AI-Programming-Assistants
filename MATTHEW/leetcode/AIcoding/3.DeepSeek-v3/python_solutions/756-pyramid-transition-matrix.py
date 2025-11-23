class Solution:
    def pyramidTransition(self, bottom: str, allowed: List[str]) -> bool:
        from collections import defaultdict
        from itertools import product

        pyramid = defaultdict(list)
        for a, b, c in allowed:
            pyramid[(a, b)].append(c)

        def dfs(current_level):
            if len(current_level) == 1:
                return True
            next_level_candidates = []
            for i in range(len(current_level) - 1):
                key = (current_level[i], current_level[i+1])
                if key not in pyramid:
                    return False
                next_level_candidates.append(pyramid[key])
            for possible in product(*next_level_candidates):
                if dfs(''.join(possible)):
                    return True
            return False

        return dfs(bottom)
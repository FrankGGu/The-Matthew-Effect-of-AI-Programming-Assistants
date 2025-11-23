class Solution:
    def permutation(self, s: str) -> List[str]:
        from itertools import permutations
        return sorted(set([''.join(p) for p in permutations(s)]))
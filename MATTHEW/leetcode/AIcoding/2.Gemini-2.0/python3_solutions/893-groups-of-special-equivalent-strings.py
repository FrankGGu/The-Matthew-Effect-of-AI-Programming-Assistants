class Solution:
    def numSpecialEquivGroups(self, A: List[str]) -> int:
        def special_equiv(s):
            odd = sorted([s[i] for i in range(len(s)) if i % 2 != 0])
            even = sorted([s[i] for i in range(len(s)) if i % 2 == 0])
            return tuple(even + odd)

        seen = set()
        for s in A:
            seen.add(special_equiv(s))
        return len(seen)
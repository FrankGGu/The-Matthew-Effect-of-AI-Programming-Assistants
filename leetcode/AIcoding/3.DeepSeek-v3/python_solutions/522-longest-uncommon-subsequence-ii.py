class Solution:
    def findLUSlength(self, strs: List[str]) -> int:
        def is_subsequence(s, t):
            t = iter(t)
            return all(c in t for c in s)

        strs.sort(key=lambda x: -len(x))
        for i, s in enumerate(strs):
            found = False
            for j, t in enumerate(strs):
                if i == j:
                    continue
                if is_subsequence(s, t):
                    found = True
                    break
            if not found:
                return len(s)
        return -1
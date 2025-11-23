class Solution:
    def findLUSlength(self, strs: List[str]) -> int:
        def is_subsequence(s, t):
            i = j = 0
            while i < len(s) and j < len(t):
                if s[i] == t[j]:
                    i += 1
                j += 1
            return i == len(s)

        strs.sort(key=len, reverse=True)
        for i, s in enumerate(strs):
            unique = True
            for j, t in enumerate(strs):
                if i == j:
                    continue
                if is_subsequence(s, t):
                    unique = False
                    break
            if unique:
                return len(s)
        return -1
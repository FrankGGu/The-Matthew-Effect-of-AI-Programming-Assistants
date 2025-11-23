class Solution:
    def findLongestSubsequence(self, strs: List[str]) -> str:
        def isSubsequence(s, t):
            it = iter(t)
            return all(c in it for c in s)

        strs.sort(key=lambda x: -len(x))
        for i, s in enumerate(strs):
            if all(not isSubsequence(s, strs[j]) for j in range(len(strs)) if i != j):
                return s
        return ""
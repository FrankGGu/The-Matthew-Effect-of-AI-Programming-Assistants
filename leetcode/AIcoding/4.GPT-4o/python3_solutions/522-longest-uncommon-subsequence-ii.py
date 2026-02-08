class Solution:
    def findLUSlength(self, strs: List[str]) -> int:
        def is_subsequence(s1, s2):
            it = iter(s2)
            return all(c in it for c in s1)

        max_length = -1
        for i in range(len(strs)):
            if all(not is_subsequence(strs[i], strs[j]) for j in range(len(strs)) if i != j):
                max_length = max(max_length, len(strs[i]))
        return max_length
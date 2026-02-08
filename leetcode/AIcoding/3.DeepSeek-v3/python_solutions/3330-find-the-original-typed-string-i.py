class Solution:
    def findOriginalString(self, typed: str) -> str:
        original = []
        i = 0
        n = len(typed)
        while i < n:
            original.append(typed[i])
            i += 1
            while i < n and typed[i] == original[-1]:
                i += 1
        return ''.join(original)
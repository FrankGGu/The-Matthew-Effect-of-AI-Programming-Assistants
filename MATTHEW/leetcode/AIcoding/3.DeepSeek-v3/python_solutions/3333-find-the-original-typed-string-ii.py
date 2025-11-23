class Solution:
    def findOriginalString(self, typed: str) -> str:
        original = []
        i = 0
        n = len(typed)

        while i < n:
            original.append(typed[i])
            j = i + 1
            while j < n and typed[j] == typed[i]:
                j += 1
            i = j

        return ''.join(original)
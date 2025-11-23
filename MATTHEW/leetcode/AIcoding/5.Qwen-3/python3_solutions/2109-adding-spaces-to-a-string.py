class Solution:
    def addSpaces(self, s: str, spaces: List[int]) -> str:
        result = []
        n = len(s)
        m = len(spaces)
        i = 0
        j = 0
        while i < n:
            if j < m and i == spaces[j]:
                result.append(' ')
                j += 1
            result.append(s[i])
            i += 1
        return ''.join(result)
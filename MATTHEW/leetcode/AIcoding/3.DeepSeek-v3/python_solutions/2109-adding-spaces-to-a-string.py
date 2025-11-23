class Solution:
    def addSpaces(self, s: str, spaces: List[int]) -> str:
        result = []
        prev = 0
        for space in spaces:
            result.append(s[prev:space])
            prev = space
        result.append(s[prev:])
        return ' '.join(result)
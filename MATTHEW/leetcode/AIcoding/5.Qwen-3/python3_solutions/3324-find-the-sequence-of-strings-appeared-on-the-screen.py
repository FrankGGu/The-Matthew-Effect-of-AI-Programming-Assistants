class Solution:
    def stringSequence(self, target: str) -> List[str]:
        result = []
        current = ""
        for char in target:
            current += char
            result.append(current)
        return result
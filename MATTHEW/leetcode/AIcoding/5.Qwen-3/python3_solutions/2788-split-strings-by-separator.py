class Solution:
    def splitWordsBySeparator(self, words: List[str], separator: str) -> List[str]:
        result = []
        for word in words:
            parts = word.split(separator)
            result.extend(parts)
        return result
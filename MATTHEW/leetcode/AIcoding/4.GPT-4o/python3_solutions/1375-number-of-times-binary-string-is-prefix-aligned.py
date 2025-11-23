class Solution:
    def prefixCount(self, s: str, words: List[str]) -> int:
        return sum(1 for word in words if s.startswith(word))
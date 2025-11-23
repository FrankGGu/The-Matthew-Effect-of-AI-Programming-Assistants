class Solution:
    def truncateSentence(self, s: str, k: int) -> str:
        words = s.split()
        truncated = ' '.join(words[:k])
        return truncated
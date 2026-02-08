class Solution:
    def truncateSentence(self, s: str, k: int) -> str:
        words = s.split(' ')
        truncated_words = words[:k]
        return ' '.join(truncated_words)
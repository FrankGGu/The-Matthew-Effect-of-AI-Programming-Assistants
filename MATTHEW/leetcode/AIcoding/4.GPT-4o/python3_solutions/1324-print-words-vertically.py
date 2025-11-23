class Solution:
    def printVertically(self, s: str) -> List[str]:
        words = s.split()
        max_length = max(len(word) for word in words)
        result = []

        for i in range(max_length):
            vertical_word = ''.join(word[i] if i < len(word) else ' ' for word in words).rstrip()
            result.append(vertical_word)

        return result
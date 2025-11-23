class Solution:
    def checkIfPangram(self, sentence: str) -> bool:
        seen_chars = set()
        for char in sentence:
            seen_chars.add(char)
        return len(seen_chars) == 26
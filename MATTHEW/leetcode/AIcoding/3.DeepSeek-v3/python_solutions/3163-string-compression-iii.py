class Solution:
    def compressedString(self, word: str) -> str:
        if not word:
            return ""

        compressed = []
        current_char = word[0]
        count = 1

        for char in word[1:]:
            if char == current_char:
                count += 1
            else:
                compressed.append(f"{count}{current_char}")
                current_char = char
                count = 1

        compressed.append(f"{count}{current_char}")

        return ''.join(compressed)
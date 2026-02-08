class Solution:
    def compressString(self, word: str) -> str:
        if not word:
            return ""

        compressed_parts = []
        i = 0
        n = len(word)

        while i < n:
            char = word[i]
            count = 0
            j = i
            while j < n and word[j] == char:
                count += 1
                j += 1

            compressed_parts.append(char)
            if count > 1:
                compressed_parts.append(str(count))

            i = j

        return "".join(compressed_parts)
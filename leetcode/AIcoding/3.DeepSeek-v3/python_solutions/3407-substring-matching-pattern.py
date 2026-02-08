class Solution:
    def findSubstring(self, s: str, words: List[str]) -> List[int]:
        if not s or not words:
            return []

        word_len = len(words[0])
        total_len = word_len * len(words)
        word_count = {}

        for word in words:
            if word in word_count:
                word_count[word] += 1
            else:
                word_count[word] = 1

        result = []

        for i in range(len(s) - total_len + 1):
            seen = {}
            j = 0
            while j < len(words):
                start = i + j * word_len
                end = start + word_len
                current_word = s[start:end]

                if current_word not in word_count:
                    break

                if current_word in seen:
                    seen[current_word] += 1
                else:
                    seen[current_word] = 1

                if seen[current_word] > word_count[current_word]:
                    break

                j += 1

            if j == len(words):
                result.append(i)

        return result
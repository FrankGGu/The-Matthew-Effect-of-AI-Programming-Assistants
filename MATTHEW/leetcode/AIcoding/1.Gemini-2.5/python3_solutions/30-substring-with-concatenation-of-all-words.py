import collections

class Solution:
    def findSubstring(self, s: str, words: List[str]) -> List[int]:
        if not s or not words:
            return []

        word_len = len(words[0])
        num_words = len(words)
        total_len = word_len * num_words
        n = len(s)

        if n < total_len:
            return []

        word_counts = collections.Counter(words)
        result = []

        for i in range(word_len):
            left = i
            current_word_counts = collections.Counter()
            count = 0

            for j in range(i, n - word_len + 1, word_len):
                word = s[j : j + word_len]

                if word in word_counts:
                    current_word_counts[word] += 1
                    count += 1

                    while current_word_counts[word] > word_counts[word]:
                        leftmost_word = s[left : left + word_len]
                        current_word_counts[leftmost_word] -= 1
                        count -= 1
                        left += word_len

                    if count == num_words:
                        result.append(left)

                        leftmost_word = s[left : left + word_len]
                        current_word_counts[leftmost_word] -= 1
                        count -= 1
                        left += word_len

                else:
                    current_word_counts.clear()
                    count = 0
                    left = j + word_len

        return result
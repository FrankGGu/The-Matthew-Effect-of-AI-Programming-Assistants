from collections import defaultdict

class Solution:
    def findSubstring(self, s: str, words: List[str]) -> List[int]:
        if not s or not words:
            return []

        word_len = len(words[0])
        total_words = len(words)
        total_len = word_len * total_words
        s_len = len(s)
        result = []

        word_count = defaultdict(int)
        for word in words:
            word_count[word] += 1

        for i in range(word_len):
            left = i
            current_count = defaultdict(int)
            count = 0
            for j in range(i, s_len - word_len + 1, word_len):
                current_word = s[j:j + word_len]
                if current_word in word_count:
                    current_count[current_word] += 1
                    count += 1
                    while current_count[current_word] > word_count[current_word]:
                        left_word = s[left:left + word_len]
                        current_count[left_word] -= 1
                        count -= 1
                        left += word_len
                    if count == total_words:
                        result.append(left)
                        left_word = s[left:left + word_len]
                        current_count[left_word] -= 1
                        count -= 1
                        left += word_len
                else:
                    current_count.clear()
                    count = 0
                    left = j + word_len
        return result
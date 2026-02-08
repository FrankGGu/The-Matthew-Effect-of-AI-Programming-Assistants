from typing import List

class Solution:
    def wordSubsets(self, words1: List[str], words2: List[str]) -> List[str]:

        def count_chars(word: str) -> List[int]:
            counts = [0] * 26
            for char in word:
                counts[ord(char) - ord('a')] += 1
            return counts

        b_max_counts = [0] * 26
        for word2 in words2:
            current_word2_counts = count_chars(word2)
            for i in range(26):
                b_max_counts[i] = max(b_max_counts[i], current_word2_counts[i])

        result = []
        for word1 in words1:
            word1_counts = count_chars(word1)
            is_universal = True
            for i in range(26):
                if word1_counts[i] < b_max_counts[i]:
                    is_universal = False
                    break
            if is_universal:
                result.append(word1)

        return result
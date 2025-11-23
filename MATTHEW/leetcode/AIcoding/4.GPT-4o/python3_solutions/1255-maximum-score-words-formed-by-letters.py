from collections import Counter

class Solution:
    def maxScoreWords(self, words: List[str], letters: List[str], score: List[int]) -> int:
        letter_count = Counter(letters)
        max_score = 0

        def backtrack(index, current_score, current_count):
            nonlocal max_score
            if index == len(words):
                max_score = max(max_score, current_score)
                return

            # Exclude the current word
            backtrack(index + 1, current_score, current_count)

            # Include the current word
            word_count = Counter(words[index])
            if all(current_count[char] + word_count[char] <= letter_count[char] for char in word_count):
                new_count = current_count.copy()
                for char in word_count:
                    new_count[char] += word_count[char]
                word_score = sum(word_count[char] * score[ord(char) - ord('a')] for char in word_count)
                backtrack(index + 1, current_score + word_score, new_count)

        backtrack(0, 0, Counter())
        return max_score
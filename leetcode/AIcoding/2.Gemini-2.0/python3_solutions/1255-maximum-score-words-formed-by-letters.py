from collections import Counter

class Solution:
    def maxScoreWords(self, words: list[str], letters: list[str], score: list[int]) -> int:
        letter_counts = Counter(letters)
        max_score = 0

        def calculate_score(word):
            word_score = 0
            for char in word:
                word_score += score[ord(char) - ord('a')]
            return word_score

        def backtrack(index, current_score, current_counts):
            nonlocal max_score
            max_score = max(max_score, current_score)

            for i in range(index, len(words)):
                word = words[i]
                word_counts = Counter(word)

                valid = True
                new_counts = current_counts.copy()
                for char, count in word_counts.items():
                    if current_counts[char] < count:
                        valid = False
                        break
                    new_counts[char] -= count

                if valid:
                    backtrack(i + 1, current_score + calculate_score(word), new_counts)

        backtrack(0, 0, letter_counts)
        return max_score
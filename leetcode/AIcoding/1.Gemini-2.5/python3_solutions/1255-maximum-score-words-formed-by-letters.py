from typing import List

class Solution:
    def maxScoreWords(self, words: List[str], letters: List[str], score: List[int]) -> int:
        # 1. Initialize available letter counts
        available_letters_count = [0] * 26
        for char_code in map(ord, letters):
            available_letters_count[char_code - ord('a')] += 1

        # 2. Pre-calculate word scores and letter counts for each word
        n = len(words)
        word_scores = [0] * n
        word_letter_counts = [[0] * 26 for _ in range(n)]

        for i in range(n):
            current_word = words[i]
            current_word_score = 0
            for char_code in map(ord, current_word):
                idx = char_code - ord('a')
                word_letter_counts[i][idx] += 1
                current_word_score += score[idx]
            word_scores[i] = current_word_score

        # 3. Backtracking function
        def backtrack(index, current_available_letters_count):
            if index == n:
                return 0

            # Option 1: Don't take the current word
            max_current_score = backtrack(index + 1, current_available_letters_count)

            # Option 2: Try to take the current word
            can_take_word = True
            temp_word_score = word_scores[index]
            temp_word_letter_count = word_letter_counts[index]

            # Check if enough letters are available
            for k in range(26):
                if current_available_letters_count[k] < temp_word_letter_count[k]:
                    can_take_word = False
                    break

            if can_take_word:
                # If possible, take the word and recurse
                for k in range(26):
                    current_available_letters_count[k] -= temp_word_letter_count[k]

                score_if_taken = temp_word_score + backtrack(index + 1, current_available_letters_count)
                max_current_score = max(max_current_score, score_if_taken)

                # Backtrack: restore letters for other branches
                for k in range(26):
                    current_available_letters_count[k] += temp_word_letter_count[k]

            return max_current_score

        return backtrack(0, available_letters_count)
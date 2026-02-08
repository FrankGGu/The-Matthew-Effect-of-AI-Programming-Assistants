class Solution:
    def maxScoreWords(self, words: List[str], letters: List[str], score: List[int]) -> int:
        from collections import Counter

        letter_count = Counter(letters)
        max_score = 0

        def backtrack(index, current_count, current_score):
            nonlocal max_score
            if index == len(words):
                if current_score > max_score:
                    max_score = current_score
                return

            word = words[index]
            word_count = Counter(word)

            can_form = True
            for c in word_count:
                if word_count[c] > current_count.get(c, 0):
                    can_form = False
                    break

            if can_form:
                new_count = current_count.copy()
                for c in word_count:
                    new_count[c] -= word_count[c]
                word_score = sum(score[ord(c) - ord('a')] for c in word)
                backtrack(index + 1, new_count, current_score + word_score)

            backtrack(index + 1, current_count, current_score)

        backtrack(0, letter_count, 0)
        return max_score
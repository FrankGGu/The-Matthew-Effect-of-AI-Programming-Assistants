class Solution:
    def maxScoreWords(self, words: List[str], letters: List[str], score: List[int]) -> int:
        from collections import Counter

        def word_to_count(word):
            return Counter(word)

        def count_to_score(count):
            total = 0
            for ch, freq in count.items():
                total += score[ord(ch) - ord('a')] * freq
            return total

        letter_count = Counter(letters)
        word_counts = [word_to_count(word) for word in words]

        def backtrack(index, current_count):
            if index == len(words):
                return count_to_score(current_count)
            # Skip current word
            max_score = backtrack(index + 1, current_count)
            # Take current word if possible
            word_count = word_counts[index]
            can_take = True
            for ch, freq in word_count.items():
                if current_count[ch] < freq:
                    can_take = False
                    break
            if can_take:
                for ch, freq in word_count.items():
                    current_count[ch] -= freq
                max_score = max(max_score, backtrack(index + 1, current_count))
                for ch, freq in word_count.items():
                    current_count[ch] += freq
            return max_score

        return backtrack(0, letter_count)
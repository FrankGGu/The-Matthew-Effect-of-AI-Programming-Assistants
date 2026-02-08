from typing import List

class Solution:
    def findSecretWord(self, wordlist: List[str], master: 'Master') -> None:

        def count_matches(word1: str, word2: str) -> int:
            matches = 0
            for i in range(len(word1)):
                if word1[i] == word2[i]:
                    matches += 1
            return matches

        current_possible_words = list(wordlist)

        for _ in range(10):
            if not current_possible_words:
                break

            best_guess_candidate = ""
            min_max_group_size = float('inf')

            for candidate_word in current_possible_words:
                match_distribution = [0] * 7

                for other_word in current_possible_words:
                    m = count_matches(candidate_word, other_word)
                    match_distribution[m] += 1

                max_group_size_for_candidate = max(match_distribution)

                if max_group_size_for_candidate < min_max_group_size:
                    min_max_group_size = max_group_size_for_candidate
                    best_guess_candidate = candidate_word

            guess_result = master.guess(best_guess_candidate)

            if guess_result == 6:
                return

            next_possible_words = []
            for word in current_possible_words:
                if count_matches(best_guess_candidate, word) == guess_result:
                    next_possible_words.append(word)

            current_possible_words = next_possible_words
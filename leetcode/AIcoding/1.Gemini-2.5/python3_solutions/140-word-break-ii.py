from typing import List

class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> List[str]:
        word_set = set(wordDict)
        memo = {}

        def backtrack(start_index):
            if start_index == len(s):
                return [""]

            if start_index in memo:
                return memo[start_index]

            results_for_current_start = []
            for i in range(start_index, len(s)):
                word = s[start_index : i + 1]
                if word in word_set:
                    suffix_sentences = backtrack(i + 1)

                    for suffix in suffix_sentences:
                        if suffix == "":
                            results_for_current_start.append(word)
                        else:
                            results_for_current_start.append(word + " " + suffix)

            memo[start_index] = results_for_current_start
            return results_for_current_start

        return backtrack(0)
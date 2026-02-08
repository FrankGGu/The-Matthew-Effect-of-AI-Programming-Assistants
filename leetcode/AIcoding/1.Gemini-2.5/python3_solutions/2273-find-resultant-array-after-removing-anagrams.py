from typing import List

class Solution:
    def removeAnagrams(self, words: List[str]) -> List[str]:
        if not words:
            return []

        result = [words[0]]

        for i in range(1, len(words)):
            current_word = words[i]
            last_added_word = result[-1]

            sorted_current = "".join(sorted(current_word))
            sorted_last_added = "".join(sorted(last_added_word))

            if sorted_current != sorted_last_added:
                result.append(current_word)

        return result
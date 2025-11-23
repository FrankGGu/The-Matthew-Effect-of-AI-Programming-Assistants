from typing import List

class Solution:
    def numSpecialEquivGroups(self, words: List[str]) -> int:
        unique_keys = set()

        for word in words:
            even_chars = []
            odd_chars = []

            for i, char in enumerate(word):
                if i % 2 == 0:
                    even_chars.append(char)
                else:
                    odd_chars.append(char)

            key = (
                "".join(sorted(even_chars)),
                "".join(sorted(odd_chars))
            )
            unique_keys.add(key)

        return len(unique_keys)
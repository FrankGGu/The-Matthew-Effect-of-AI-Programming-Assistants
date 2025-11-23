from typing import List

class Solution:
    def letterCasePermutation(self, s: str) -> List[str]:
        result = []
        n = len(s)
        current_permutation = [''] * n

        def backtrack(index):
            if index == n:
                result.append("".join(current_permutation))
                return

            char = s[index]
            if char.isalpha():
                current_permutation[index] = char.lower()
                backtrack(index + 1)

                current_permutation[index] = char.upper()
                backtrack(index + 1)
            else:
                current_permutation[index] = char
                backtrack(index + 1)

        backtrack(0)
        return result
from typing import List

class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        if not digits:
            return []

        phone_map = {
            '2': "abc",
            '3': "def",
            '4': "ghi",
            '5': "jkl",
            '6': "mno",
            '7': "pqrs",
            '8': "tuv",
            '9': "wxyz"
        }

        output = []

        def backtrack(combination, next_digit_index):
            if next_digit_index == len(digits):
                output.append(combination)
                return

            digit = digits[next_digit_index]
            letters = phone_map[digit]

            for letter in letters:
                backtrack(combination + letter, next_digit_index + 1)

        backtrack("", 0)
        return output
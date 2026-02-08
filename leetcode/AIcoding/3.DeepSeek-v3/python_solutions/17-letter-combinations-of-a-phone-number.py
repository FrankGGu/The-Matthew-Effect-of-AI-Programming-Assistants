class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        if not digits:
            return []

        digit_to_letters = {
            '2': ['a', 'b', 'c'],
            '3': ['d', 'e', 'f'],
            '4': ['g', 'h', 'i'],
            '5': ['j', 'k', 'l'],
            '6': ['m', 'n', 'o'],
            '7': ['p', 'q', 'r', 's'],
            '8': ['t', 'u', 'v'],
            '9': ['w', 'x', 'y', 'z']
        }

        combinations = []
        self.backtrack(digits, digit_to_letters, 0, [], combinations)
        return combinations

    def backtrack(self, digits, digit_to_letters, index, path, combinations):
        if index == len(digits):
            combinations.append(''.join(path))
            return

        current_digit = digits[index]
        for letter in digit_to_letters[current_digit]:
            path.append(letter)
            self.backtrack(digits, digit_to_letters, index + 1, path, combinations)
            path.pop()
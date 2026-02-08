class Solution:
    def generateBinaryStrings(self, n: int) -> list[str]:
        result = []
        current_string_chars = [''] * n

        def backtrack(index, last_char_was_zero):
            if index == n:
                result.append("".join(current_string_chars))
                return

            current_string_chars[index] = '1'
            backtrack(index + 1, False)

            if not last_char_was_zero:
                current_string_chars[index] = '0'
                backtrack(index + 1, True)

        backtrack(0, False)
        return result
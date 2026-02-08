class Solution:
    def isSolvable(self, words: list[str], result: str) -> bool:
        unique_chars = []
        char_to_digit = {}
        digit_used = [False] * 10
        leading_chars = set()

        for word in words:
            if len(word) > 1:
                leading_chars.add(word[0])
            for char in word:
                if char not in char_to_digit:
                    char_to_digit[char] = -1
                    unique_chars.append(char)

        if len(result) > 1:
            leading_chars.add(result[0])
        for char in result:
            if char not in char_to_digit:
                char_to_digit[char] = -1
                unique_chars.append(char)

        def get_word_value(word):
            value = 0
            for char in word:
                value = value * 10 + char_to_digit[char]
            return value

        def backtrack(k):
            if k == len(unique_chars):
                sum_words = 0
                for word in words:
                    sum_words += get_word_value(word)

                result_value = get_word_value(result)

                return sum_words == result_value

            char = unique_chars[k]

            for digit in range(10):
                if digit_used[digit]:
                    continue

                if char in leading_chars and digit == 0:
                    continue

                char_to_digit[char] = digit
                digit_used[digit] = True

                if backtrack(k + 1):
                    return True

                digit_used[digit] = False
                char_to_digit[char] = -1

            return False

        return backtrack(0)
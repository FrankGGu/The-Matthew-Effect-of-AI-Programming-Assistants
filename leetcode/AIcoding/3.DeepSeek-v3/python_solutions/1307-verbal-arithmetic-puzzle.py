class Solution:
    def isSolvable(self, words: List[str], result: str) -> bool:
        from collections import defaultdict

        all_words = words + [result]
        first_chars = {word[0] for word in all_words if len(word) > 1}
        n = max(len(word) for word in all_words)
        if len(result) < n:
            return False

        char_to_digit = {}
        digit_to_char = {}

        def backtrack(pos, word_idx, carry, used_digits):
            if pos == n:
                return carry == 0

            if word_idx == len(all_words):
                sum_val = carry
                for word in words:
                    if pos < len(word):
                        sum_val += char_to_digit[word[-(pos + 1)]]
                carry, digit = divmod(sum_val, 10)
                if result[-(pos + 1)] in char_to_digit:
                    if char_to_digit[result[-(pos + 1)]] != digit:
                        return False
                else:
                    if digit in digit_to_char or (digit == 0 and result[-(pos + 1)] in first_chars):
                        return False
                    char_to_digit[result[-(pos + 1)]] = digit
                    digit_to_char[digit] = result[-(pos + 1)]
                    used = used_digits | {digit}
                res = backtrack(pos + 1, 0, carry, used)
                if result[-(pos + 1)] not in char_to_digit:
                    del digit_to_char[digit]
                    del char_to_digit[result[-(pos + 1)]]
                return res

            word = all_words[word_idx]
            if pos >= len(word):
                return backtrack(pos, word_idx + 1, carry, used_digits)
            c = word[-(pos + 1)]
            if c in char_to_digit:
                return backtrack(pos, word_idx + 1, carry, used_digits)
            for d in range(10):
                if d in digit_to_char:
                    continue
                if d == 0 and c in first_chars:
                    continue
                char_to_digit[c] = d
                digit_to_char[d] = c
                if backtrack(pos, word_idx + 1, carry, used_digits | {d}):
                    return True
                del char_to_digit[c]
                del digit_to_char[d]
            return False

        return backtrack(0, 0, 0, set())
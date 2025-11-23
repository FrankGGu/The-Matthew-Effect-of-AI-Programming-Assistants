class Solution:
    def isSolvable(self, words: List[str], result: str) -> bool:
        from itertools import permutations

        unique_chars = set("".join(words) + result)
        if len(unique_chars) > 10:
            return False

        first_letters = set(word[0] for word in words + [result])
        unique_chars = list(unique_chars)

        for perm in permutations(range(10), len(unique_chars)):
            char_to_digit = dict(zip(unique_chars, perm))
            if any(char_to_digit[word[0]] == 0 for word in first_letters):
                continue

            total = sum(int("".join(str(char_to_digit[c]) for c in word)) for word in words)
            if total == int("".join(str(char_to_digit[c]) for c in result)):
                return True

        return False
import collections

class Solution:
    def countCharacters(self, words: list[str], chars: str) -> int:
        chars_count = collections.Counter(chars)
        total_length = 0

        for word in words:
            word_count = collections.Counter(word)
            is_good = True
            for char, count in word_count.items():
                if chars_count[char] < count:
                    is_good = False
                    break
            if is_good:
                total_length += len(word)

        return total_length
class Solution:
    def countDivisibleSubstrings(self, word: str) -> int:
        digit_map = {
            'a': 1,
            'b': 1,
            'c': 2,
            'd': 2,
            'e': 2,
            'f': 3,
            'g': 3,
            'h': 3,
            'i': 4,
            'j': 4,
            'k': 4,
            'l': 5,
            'm': 5,
            'n': 5,
            'o': 6,
            'p': 6,
            'q': 6,
            'r': 7,
            's': 7,
            't': 7,
            'u': 8,
            'v': 8,
            'w': 8,
            'x': 9,
            'y': 9,
            'z': 9
        }
        count = 0
        n = len(word)
        for i in range(n):
            total = 0
            for j in range(i, n):
                total += digit_map[word[j]]
                length = j - i + 1
                if total % length == 0:
                    count += 1
        return count
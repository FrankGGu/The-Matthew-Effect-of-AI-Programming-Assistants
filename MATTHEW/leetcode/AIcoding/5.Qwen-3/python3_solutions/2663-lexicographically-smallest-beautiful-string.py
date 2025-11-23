class Solution:
    def shortestBeautifulString(self, n: int, k: int, target: str) -> str:
        from itertools import product

        def is_beautiful(s):
            for i in range(len(s) - 1):
                if s[i] == s[i + 1]:
                    return False
            return True

        chars = [chr(ord('a') + i) for i in range(k)]
        for length in range(1, n + 1):
            for candidate in product(chars, repeat=length):
                s = ''.join(candidate)
                if is_beautiful(s):
                    return s
        return ""
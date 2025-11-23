class Solution:
    def countBeautifulSubstrings(self, s: str) -> int:
        count = 0
        n = len(s)

        for i in range(n):
            for j in range(i, n):
                substring = s[i:j + 1]
                if self.is_beautiful(substring):
                    count += 1

        return count

    def is_beautiful(self, substring: str) -> bool:
        return len(substring) > 1 and all(c in 'aeiou' for c in substring)
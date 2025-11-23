class Solution:
    def findTheDifference(self, s: str, t: str) -> str:
        from collections import defaultdict

        count = defaultdict(int)

        for char in s:
            count[char] += 1

        for char in t:
            count[char] -= 1
            if count[char] < 0:
                return char

        return ""
class Solution:
    def canConstruct(self, s: str, k: int) -> bool:
        if k > len(s):
            return False

        counts = {}
        for char in s:
            counts[char] = counts.get(char, 0) + 1

        odd_count = 0
        for count in counts.values():
            if count % 2 != 0:
                odd_count += 1

        return odd_count <= k
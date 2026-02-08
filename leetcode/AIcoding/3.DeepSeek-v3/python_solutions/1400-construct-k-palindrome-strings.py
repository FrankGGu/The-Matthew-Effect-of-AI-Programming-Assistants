class Solution:
    def canConstruct(self, s: str, k: int) -> bool:
        if len(s) < k:
            return False
        freq = {}
        for char in s:
            freq[char] = freq.get(char, 0) + 1
        odd_count = 0
        for count in freq.values():
            if count % 2 != 0:
                odd_count += 1
        return odd_count <= k
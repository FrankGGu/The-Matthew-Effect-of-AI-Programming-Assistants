class Solution:
    def longestValidSubstring(self, word: str, forbidden: list[str]) -> int:
        forbidden_set = set(forbidden)
        n = len(word)
        max_len = 0
        left = 0
        for right in range(n):
            while any(word[left:right+1].find(f) != -1 for f in forbidden_set):
                left += 1
            max_len = max(max_len, right - left + 1)
        return max_len
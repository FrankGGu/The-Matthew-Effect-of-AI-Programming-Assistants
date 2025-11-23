class Solution:
    def longestValidSubstring(self, word: str, forbidden: List[str]) -> int:
        forbidden_set = set(forbidden)
        max_len = 0
        left = 0
        n = len(word)

        for right in range(n):
            for i in range(right, max(left, right - 10) - 1, -1):
                substring = word[i:right+1]
                if substring in forbidden_set:
                    left = i + 1
                    break
            max_len = max(max_len, right - left + 1)

        return max_len
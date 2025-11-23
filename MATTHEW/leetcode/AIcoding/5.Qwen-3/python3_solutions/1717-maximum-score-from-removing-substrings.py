class Solution:
    def maximumScore(self, s: str, k: int) -> int:
        left = k
        right = k
        max_score = 0
        count = [0] * 26
        count[ord(s[k]) - ord('a')] = 1
        while left > 0 or right < len(s) - 1:
            if left == 0:
                right += 1
            elif right == len(s) - 1:
                left -= 1
            else:
                if ord(s[left - 1]) - ord('a') < ord(s[right + 1]) - ord('a'):
                    left -= 1
                else:
                    right += 1
            count[ord(s[left]) - ord('a')] += 1
            count[ord(s[right]) - ord('a')] += 1
            unique = sum(1 for c in count if c > 0)
            max_score = max(max_score, (right - left + 1) * unique)
        return max_score
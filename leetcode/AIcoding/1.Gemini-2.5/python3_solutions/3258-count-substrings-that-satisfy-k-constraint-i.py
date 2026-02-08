import collections

class Solution:
    def countSubstrings(self, s: str, k: int) -> int:
        n = len(s)
        count = 0
        left = 0
        char_counts = collections.defaultdict(int)
        distinct_chars = 0

        for right in range(n):
            char_counts[s[right]] += 1
            if char_counts[s[right]] == 1:
                distinct_chars += 1

            while distinct_chars > k:
                char_counts[s[left]] -= 1
                if char_counts[s[left]] == 0:
                    distinct_chars -= 1
                left += 1

            count += (right - left + 1)

        return count
class Solution:
    def longestSemiRepetitiveSubstring(self, s: str) -> int:
        max_len = 0
        last_seen = {}
        start = 0
        repeat_count = 0

        for end in range(len(s)):
            if s[end] in last_seen:
                if last_seen[s[end]] >= start:
                    repeat_count += 1
                    start = last_seen[s[end]] + 1

            last_seen[s[end]] = end

            if repeat_count <= 1:
                max_len = max(max_len, end - start + 1)

        return max_len
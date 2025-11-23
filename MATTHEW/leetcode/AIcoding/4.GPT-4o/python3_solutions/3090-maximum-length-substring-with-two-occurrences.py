class Solution:
    def maximumLength(self, s: str) -> int:
        max_length = 0
        last_seen = {}
        start = 0

        for end in range(len(s)):
            if s[end] in last_seen:
                last_seen[s[end]] += 1
            else:
                last_seen[s[end]] = 1

            while len(last_seen) > 2:
                last_seen[s[start]] -= 1
                if last_seen[s[start]] == 0:
                    del last_seen[s[start]]
                start += 1

            max_length = max(max_length, end - start + 1)

        return max_length
class Solution:
    def longestRepeatingSubsequence(self, s: str, k: int) -> str:
        from collections import deque

        def is_possible(seq):
            count = 0
            i = 0
            for c in s:
                if i < len(seq) and c == seq[i]:
                    i += 1
            return i == len(seq)

        def generate_candidates(prefix, start, length, candidates):
            if len(prefix) == length:
                candidates.append(prefix)
                return
            for i in range(start, len(s)):
                if i > start and s[i] == s[i - 1]:
                    continue
                generate_candidates(prefix + s[i], i + 1, length, candidates)

        n = len(s)
        max_len = 0
        result = ""
        for length in range(n, 0, -1):
            candidates = []
            generate_candidates("", 0, length, candidates)
            for candidate in candidates:
                if is_possible(candidate):
                    return candidate
        return ""
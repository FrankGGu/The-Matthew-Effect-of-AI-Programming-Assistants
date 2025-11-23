class Solution:
    def largestVariance(self, s: str) -> int:
        from collections import defaultdict

        def kmp_failure_function(pattern):
            n = len(pattern)
            fail = [0] * n
            j = 0
            for i in range(1, n):
                while j > 0 and pattern[i] != pattern[j]:
                    j = fail[j - 1]
                if pattern[i] == pattern[j]:
                    j += 1
                    fail[i] = j
                else:
                    fail[i] = 0
            return fail

        def kmp_search(text, pattern, fail):
            j = 0
            max_count = 0
            for i in range(len(text)):
                while j > 0 and text[i] != pattern[j]:
                    j = fail[j - 1]
                if text[i] == pattern[j]:
                    j += 1
                if j == len(pattern):
                    max_count += 1
                    j = fail[j - 1]
            return max_count

        def get_max_variance(a, b, s):
            max_var = 0
            count_a = 0
            count_b = 0
            has_b = False
            for c in s:
                if c == a:
                    count_a += 1
                elif c == b:
                    count_b += 1
                    has_b = True
                if has_b and count_a < count_b:
                    count_a = 0
                    count_b = 0
                    has_b = False
                if has_b:
                    max_var = max(max_var, count_a - count_b)
            return max_var if has_b else 0

        unique_chars = set(s)
        max_var = 0
        for a in unique_chars:
            for b in unique_chars:
                if a != b:
                    max_var = max(max_var, get_max_variance(a, b, s))
        return max_var
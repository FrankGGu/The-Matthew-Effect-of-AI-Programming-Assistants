class Solution:
    def getMaxRepetitions(self, s1: str, n1: int, s2: str, n2: int) -> int:
        if not s1 or not s2:
            return 0

        s1_len, s2_len = len(s1), len(s2)
        repeat_count = [0] * (s2_len + 1)
        next_index = [0] * (s2_len + 1)
        j, count = 0, 0

        for k in range(1, n1 + 1):
            for i in range(s1_len):
                if s1[i] == s2[j]:
                    j += 1
                    if j == s2_len:
                        j = 0
                        count += 1

            repeat_count[k] = count
            next_index[k] = j

            for start in range(k):
                if next_index[start] == j:
                    prefix_count = repeat_count[start]
                    pattern_count = (repeat_count[k] - repeat_count[start]) * ((n1 - start) // (k - start))
                    suffix_count = repeat_count[start + (n1 - start) % (k - start)] - repeat_count[start]
                    return (prefix_count + pattern_count + suffix_count) // n2

        return repeat_count[n1] // n2
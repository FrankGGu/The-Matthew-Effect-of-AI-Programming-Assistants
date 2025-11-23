class Solution:
    def largestVariance(self, s: str) -> int:
        max_variance = 0
        unique_chars = set(s)

        for a in unique_chars:
            for b in unique_chars:
                if a != b:
                    count_a = count_b = 0
                    for char in s:
                        if char == a:
                            count_a += 1
                        elif char == b:
                            count_b += 1

                        if count_a > 0 and count_b > 0:
                            max_variance = max(max_variance, count_a - count_b)

                        if count_b > count_a:
                            count_a = count_b = 0

        return max_variance
from collections import Counter

class Solution:
    def digitCount(self, num: str) -> bool:
        n = len(num)
        digit_counts = Counter(num)

        for i in range(n):
            expected_count = int(num[i])
            digit_char_to_check = str(i)
            actual_count = digit_counts[digit_char_to_check]

            if actual_count != expected_count:
                return False

        return True
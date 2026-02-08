import math

class Solution:
    def minSwaps(self, s: str) -> int:
        n = len(s)

        zeros_in_s = s.count('0')
        ones_in_s = s.count('1')

        if abs(zeros_in_s - ones_in_s) > 1:
            return -1

        def calculate_mismatches(target_start_char):
            required_zeros = 0
            required_ones = 0

            if target_start_char == '0':
                required_zeros = (n + 1) // 2
                required_ones = n // 2
            else:
                required_ones = (n + 1) // 2
                required_zeros = n // 2

            if zeros_in_s != required_zeros or ones_in_s != required_ones:
                return float('inf')

            mismatches = 0
            for i in range(n):
                expected_char = target_start_char if i % 2 == 0 else ('1' if target_start_char == '0' else '0')

                if s[i] != expected_char:
                    mismatches += 1

            return mismatches // 2

        ans = float('inf')

        swaps_start_with_0 = calculate_mismatches('0')
        ans = min(ans, swaps_start_with_0)

        swaps_start_with_1 = calculate_mismatches('1')
        ans = min(ans, swaps_start_with_1)

        if ans == float('inf'):
            return -1
        else:
            return ans
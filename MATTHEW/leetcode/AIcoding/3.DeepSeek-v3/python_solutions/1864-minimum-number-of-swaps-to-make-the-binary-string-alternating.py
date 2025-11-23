class Solution:
    def minSwaps(self, s: str) -> int:
        count0 = s.count('0')
        count1 = s.count('1')

        if abs(count0 - count1) > 1:
            return -1

        def calculate_swaps(start_char):
            swaps = 0
            for i, char in enumerate(s):
                expected_char = start_char if i % 2 == 0 else ('1' if start_char == '0' else '0')
                if char != expected_char:
                    swaps += 1
            return swaps // 2

        if count0 > count1:
            return calculate_swaps('0')
        elif count1 > count0:
            return calculate_swaps('1')
        else:
            return min(calculate_swaps('0'), calculate_swaps('1'))
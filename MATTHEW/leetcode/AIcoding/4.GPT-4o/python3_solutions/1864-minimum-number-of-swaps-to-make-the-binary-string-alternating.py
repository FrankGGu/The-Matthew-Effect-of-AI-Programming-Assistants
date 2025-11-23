class Solution:
    def minimumSwaps(self, s: str) -> int:
        count0 = s.count('0')
        count1 = len(s) - count0

        if abs(count0 - count1) > 1:
            return -1

        def calculate_swaps(start_char):
            swaps = 0
            for i in range(len(s)):
                expected_char = start_char if i % 2 == 0 else ('0' if start_char == '1' else '1')
                if s[i] != expected_char:
                    swaps += 1
            return swaps // 2

        return min(calculate_swaps('0'), calculate_swaps('1'))
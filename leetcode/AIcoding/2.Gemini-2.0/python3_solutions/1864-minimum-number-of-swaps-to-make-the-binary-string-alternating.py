class Solution:
    def minSwaps(self, s: str) -> int:
        n = len(s)
        zeros = 0
        ones = 0
        for char in s:
            if char == '0':
                zeros += 1
            else:
                ones += 1
        if abs(zeros - ones) > 1:
            return -1

        def calculate_swaps(start_with):
            swaps = 0
            for i in range(n):
                expected = str(i % 2) if start_with == '0' else str((i + 1) % 2)
                if s[i] != expected:
                    swaps += 1
            return swaps // 2

        if zeros > ones:
            return calculate_swaps('0')
        elif ones > zeros:
            return calculate_swaps('1')
        else:
            return min(calculate_swaps('0'), calculate_swaps('1'))
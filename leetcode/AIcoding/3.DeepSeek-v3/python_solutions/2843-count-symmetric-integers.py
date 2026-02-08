class Solution:
    def countSymmetricIntegers(self, low: int, high: int) -> int:
        count = 0
        for num in range(low, high + 1):
            s = str(num)
            n = len(s)
            if n % 2 != 0:
                continue
            half = n // 2
            left_sum = sum(int(c) for c in s[:half])
            right_sum = sum(int(c) for c in s[half:])
            if left_sum == right_sum:
                count += 1
        return count
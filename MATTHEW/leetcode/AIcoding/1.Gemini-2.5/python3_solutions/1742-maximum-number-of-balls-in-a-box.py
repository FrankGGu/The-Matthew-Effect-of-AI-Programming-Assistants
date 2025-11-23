class Solution:
    def countBalls(self, lowLimit: int, highLimit: int) -> int:
        counts = [0] * 46

        for i in range(lowLimit, highLimit + 1):
            current_num = i
            digit_sum = 0
            while current_num > 0:
                digit_sum += current_num % 10
                current_num //= 10
            counts[digit_sum] += 1

        return max(counts)
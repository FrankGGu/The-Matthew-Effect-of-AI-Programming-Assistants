class Solution:
    def countBalls(self, lowLimit: int, highLimit: int) -> int:
        box_counts = {}
        max_count = 0

        for num in range(lowLimit, highLimit + 1):
            digit_sum = 0
            n = num
            while n > 0:
                digit_sum += n % 10
                n = n // 10
            if digit_sum in box_counts:
                box_counts[digit_sum] += 1
            else:
                box_counts[digit_sum] = 1
            if box_counts[digit_sum] > max_count:
                max_count = box_counts[digit_sum]

        return max_count
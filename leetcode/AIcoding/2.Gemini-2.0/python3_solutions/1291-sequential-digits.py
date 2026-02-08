class Solution:
    def sequentialDigits(self, low: int, high: int) -> List[int]:
        result = []
        for i in range(1, 10):
            num = i
            while num <= high:
                if num >= low:
                    result.append(num)
                last_digit = num % 10
                if last_digit == 9:
                    break
                num = num * 10 + (last_digit + 1)
        result.sort()
        return result
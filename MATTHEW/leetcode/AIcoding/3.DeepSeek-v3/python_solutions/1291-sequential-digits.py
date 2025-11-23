class Solution:
    def sequentialDigits(self, low: int, high: int) -> List[int]:
        result = []
        for length in range(len(str(low)), len(str(high)) + 1):
            for start in range(1, 10 - length + 1):
                num = 0
                for i in range(start, start + length):
                    num = num * 10 + i
                if low <= num <= high:
                    result.append(num)
        return result
class Solution:
    def sequentialDigits(self, low: int, high: int) -> list[int]:
        result = []

        for i in range(1, 10):
            current_num = i
            for j in range(i + 1, 10):
                current_num = current_num * 10 + j
                if low <= current_num <= high:
                    result.append(current_num)
                elif current_num > high:
                    break

        result.sort()
        return result
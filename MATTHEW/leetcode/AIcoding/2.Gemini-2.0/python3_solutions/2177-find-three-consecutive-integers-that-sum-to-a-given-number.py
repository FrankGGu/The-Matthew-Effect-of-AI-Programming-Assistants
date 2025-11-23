class Solution:
    def sumOfThree(self, num: int) -> list[int]:
        if num % 3 != 0:
            return []
        mid = num // 3
        return [mid - 1, mid, mid + 1]
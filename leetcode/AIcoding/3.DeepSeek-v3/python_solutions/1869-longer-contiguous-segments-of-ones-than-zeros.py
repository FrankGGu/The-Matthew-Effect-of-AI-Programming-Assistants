class Solution:
    def checkZeroOnes(self, s: str) -> bool:
        max_one = 0
        max_zero = 0
        current_one = 0
        current_zero = 0

        for char in s:
            if char == '1':
                current_one += 1
                current_zero = 0
                max_one = max(max_one, current_one)
            else:
                current_zero += 1
                current_one = 0
                max_zero = max(max_zero, current_zero)

        return max_one > max_zero
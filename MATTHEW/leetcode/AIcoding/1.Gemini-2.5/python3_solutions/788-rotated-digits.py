class Solution:
    def rotatedDigits(self, n: int) -> int:
        count = 0
        for i in range(1, n + 1):
            temp = i
            is_valid_rotation = True
            is_different_rotation = False

            while temp > 0:
                digit = temp % 10
                if digit == 3 or digit == 4 or digit == 7:
                    is_valid_rotation = False
                    break
                if digit == 2 or digit == 5 or digit == 6 or digit == 9:
                    is_different_rotation = True
                temp //= 10

            if is_valid_rotation and is_different_rotation:
                count += 1

        return count
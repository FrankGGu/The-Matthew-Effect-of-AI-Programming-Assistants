class Solution:
    def isPerfectSquare(self, num: int) -> bool:
        if num < 1:
            return False

        left, right = 1, num

        while left <= right:
            mid = left + (right - left) // 2

            # Use a long type for square to avoid potential overflow in languages like Java/C++
            # In Python, integers handle arbitrary size, so this is not strictly necessary
            # but good practice for conceptual understanding.
            square = mid * mid

            if square == num:
                return True
            elif square < num:
                left = mid + 1
            else:
                right = mid - 1

        return False
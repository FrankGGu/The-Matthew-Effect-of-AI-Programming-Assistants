class Solution:
    def lastRemaining(self, n: int) -> int:
        head = 1
        remaining = n
        step = 1
        left_to_right = True

        while remaining > 1:
            if left_to_right:
                head += step
            else:  # right_to_left
                if remaining % 2 == 1:
                    head += step

            remaining //= 2
            step *= 2
            left_to_right = not left_to_right

        return head
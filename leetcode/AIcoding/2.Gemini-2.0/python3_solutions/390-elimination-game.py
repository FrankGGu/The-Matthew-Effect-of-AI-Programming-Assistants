class Solution:
    def lastRemaining(self, n: int) -> int:
        head = 1
        step = 1
        remaining = n
        left = True
        while remaining > 1:
            if left or remaining % 2 == 1:
                head = head + step
            remaining = remaining // 2
            step = step * 2
            left = not left
        return head
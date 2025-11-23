class Solution:
    def countSteppingNumbers(self, low: int, high: int) -> List[int]:
        from collections import deque

        res = []
        queue = deque()

        for i in range(1, 10):
            queue.append(i)

        if low == 0:
            res.append(0)

        while queue:
            num = queue.popleft()
            if num > high:
                continue
            if num >= low:
                res.append(num)

            last_digit = num % 10
            if last_digit > 0:
                new_num = num * 10 + (last_digit - 1)
                if new_num <= high:
                    queue.append(new_num)
            if last_digit < 9:
                new_num = num * 10 + (last_digit + 1)
                if new_num <= high:
                    queue.append(new_num)

        res.sort()
        return res
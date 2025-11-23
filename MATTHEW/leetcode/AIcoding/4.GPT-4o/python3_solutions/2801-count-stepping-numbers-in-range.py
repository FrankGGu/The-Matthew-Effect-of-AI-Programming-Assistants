class Solution:
    def countSteppingNumbers(self, low: int, high: int) -> int:
        def bfs(start):
            queue = [start]
            count = 0
            while queue:
                num = queue.pop(0)
                if low <= num <= high:
                    count += 1
                if num == 0 or num > high:
                    continue
                last_digit = num % 10
                if last_digit > 0:
                    next_num = num * 10 + (last_digit - 1)
                    if next_num <= high:
                        queue.append(next_num)
                if last_digit < 9:
                    next_num = num * 10 + (last_digit + 1)
                    if next_num <= high:
                        queue.append(next_num)
            return count

        result = 0
        for i in range(10):
            result += bfs(i)
        return result
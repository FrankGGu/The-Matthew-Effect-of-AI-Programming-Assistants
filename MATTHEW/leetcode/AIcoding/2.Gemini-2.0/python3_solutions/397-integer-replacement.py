class Solution:
    def integerReplacement(self, n: int) -> int:
        q = [(n, 0)]
        visited = {n}
        while q:
            num, steps = q.pop(0)
            if num == 1:
                return steps
            if num % 2 == 0:
                next_num = num // 2
                if next_num not in visited:
                    q.append((next_num, steps + 1))
                    visited.add(next_num)
            else:
                next_num1 = num + 1
                if next_num1 not in visited:
                    q.append((next_num1, steps + 1))
                    visited.add(next_num1)
                next_num2 = num - 1
                if next_num2 not in visited:
                    q.append((next_num2, steps + 1))
                    visited.add(next_num2)
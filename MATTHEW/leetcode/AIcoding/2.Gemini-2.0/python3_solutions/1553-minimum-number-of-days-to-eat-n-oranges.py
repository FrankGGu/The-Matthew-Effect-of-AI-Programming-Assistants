class Solution:
    def minDays(self, n: int) -> int:
        q = [(n, 0)]
        visited = {n}
        while q:
            num, days = q.pop(0)
            if num == 0:
                return days
            if num % 2 == 0 and num // 2 not in visited:
                q.append((num // 2, days + 1))
                visited.add(num // 2)
            if num % 3 == 0 and num // 3 not in visited:
                q.append((num // 3, days + 1))
                visited.add(num // 3)
            if num - 1 not in visited:
                q.append((num - 1, days + 1))
                visited.add(num - 1)
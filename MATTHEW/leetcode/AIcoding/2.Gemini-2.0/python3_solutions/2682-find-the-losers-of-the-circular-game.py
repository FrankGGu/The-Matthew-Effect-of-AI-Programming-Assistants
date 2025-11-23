class Solution:
    def circularGameLosers(self, n: int, k: int) -> list[int]:
        visited = [False] * n
        current = 0
        multiplier = 1
        while not visited[current]:
            visited[current] = True
            current = (current + multiplier * k) % n
            multiplier += 1

        losers = []
        for i in range(n):
            if not visited[i]:
                losers.append(i + 1)

        return losers
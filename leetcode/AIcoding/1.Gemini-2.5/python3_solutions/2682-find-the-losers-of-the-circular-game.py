class Solution:
    def findLosers(self, n: int, k: int) -> list[int]:
        visited = set()
        current_player = 1
        round_num = 0

        visited.add(current_player)

        while True:
            round_num += 1
            steps = round_num * k

            next_player = (current_player - 1 + steps) % n + 1

            if next_player in visited:
                break

            visited.add(next_player)
            current_player = next_player

        losers = []
        for i in range(1, n + 1):
            if i not in visited:
                losers.append(i)

        return losers
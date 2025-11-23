class Solution:
    def firstPlayer(self, players: List[int], k: int) -> int:
        count = {}
        for i in range(len(players)):
            if players[i] not in count:
                count[players[i]] = 0
            count[players[i]] += 1

            if count[players[i]] >= k:
                return players[i]
        return -1
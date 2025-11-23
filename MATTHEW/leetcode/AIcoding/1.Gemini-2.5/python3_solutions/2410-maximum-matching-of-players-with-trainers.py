class Solution:
    def matchPlayersAndTrainers(self, players: list[int], trainers: list[int]) -> int:
        players.sort()
        trainers.sort()

        player_idx = 0
        trainer_idx = 0
        matches = 0

        while player_idx < len(players) and trainer_idx < len(trainers):
            if players[player_idx] <= trainers[trainer_idx]:
                matches += 1
                player_idx += 1
            trainer_idx += 1

        return matches
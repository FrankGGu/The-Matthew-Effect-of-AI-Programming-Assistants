from collections import defaultdict

class Solution:
    def findWinners(self, matches: list[list[int]]) -> list[list[int]]:
        loss_counts = defaultdict(int)
        all_players = set()

        for winner, loser in matches:
            all_players.add(winner)
            all_players.add(loser)
            loss_counts[loser] += 1

        no_losses = []
        one_loss = []

        for player_id in sorted(list(all_players)):
            losses = loss_counts[player_id]
            if losses == 0:
                no_losses.append(player_id)
            elif losses == 1:
                one_loss.append(player_id)

        return [no_losses, one_loss]
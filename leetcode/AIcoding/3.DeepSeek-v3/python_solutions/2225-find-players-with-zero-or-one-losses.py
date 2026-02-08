class Solution:
    def findWinners(self, matches: List[List[int]]) -> List[List[int]]:
        losses = {}
        players = set()

        for winner, loser in matches:
            players.add(winner)
            players.add(loser)
            losses[loser] = losses.get(loser, 0) + 1

        no_loss = []
        one_loss = []

        for player in sorted(players):
            if losses.get(player, 0) == 0:
                no_loss.append(player)
            elif losses.get(player, 0) == 1:
                one_loss.append(player)

        return [no_loss, one_loss]
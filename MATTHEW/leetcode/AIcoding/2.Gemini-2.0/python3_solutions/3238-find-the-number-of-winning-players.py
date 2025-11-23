from typing import List

class Solution:
    def findWinners(self, matches: List[List[int]]) -> List[List[int]]:
        losses = {}
        for winner, loser in matches:
            if winner not in losses:
                losses[winner] = 0
            if loser not in losses:
                losses[loser] = 0
            losses[loser] += 1

        no_loss = []
        one_loss = []
        for player, loss_count in losses.items():
            if loss_count == 0:
                no_loss.append(player)
            elif loss_count == 1:
                one_loss.append(player)

        no_loss.sort()
        one_loss.sort()
        return [no_loss, one_loss]
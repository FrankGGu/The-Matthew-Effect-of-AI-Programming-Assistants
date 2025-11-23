from typing import List

class Solution:
    def findWinners(self, matches: List[List[int]]) -> List[List[int]]:
        losses = {}
        for match in matches:
            winner = match[0]
            loser = match[1]
            if winner not in losses:
                losses[winner] = 0
            if loser not in losses:
                losses[loser] = 0
            losses[loser] += 1

        zero_loss = []
        one_loss = []
        for player, loss_count in losses.items():
            if loss_count == 0:
                zero_loss.append(player)
            elif loss_count == 1:
                one_loss.append(player)

        zero_loss.sort()
        one_loss.sort()
        return [zero_loss, one_loss]
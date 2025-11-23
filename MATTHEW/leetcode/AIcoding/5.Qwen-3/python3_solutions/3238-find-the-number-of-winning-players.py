class Solution:
    def winningPlayers(self, matches: List[List[int]]) -> int:
        from collections import defaultdict

        score = defaultdict(int)
        for winner, loser in matches:
            score[winner] += 1
            score[loser] += 0

        return len([k for k, v in score.items() if v > 0])
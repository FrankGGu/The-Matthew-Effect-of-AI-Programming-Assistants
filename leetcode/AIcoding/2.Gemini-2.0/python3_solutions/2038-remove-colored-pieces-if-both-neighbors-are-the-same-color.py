class Solution:
    def winnerOfGame(self, colors: str) -> bool:
        a_moves = 0
        b_moves = 0
        n = len(colors)
        for i in range(1, n - 1):
            if colors[i - 1] == colors[i] == colors[i + 1]:
                if colors[i] == 'A':
                    a_moves += 1
                else:
                    b_moves += 1
        return a_moves > b_moves
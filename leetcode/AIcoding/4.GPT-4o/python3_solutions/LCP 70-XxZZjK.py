class Solution:
    def sandGame(self, sand: List[int]) -> int:
        n = len(sand)
        total = sum(sand)
        if total % n != 0:
            return -1
        target = total // n
        moves = 0
        balance = 0

        for s in sand:
            balance += s - target
            moves += abs(balance)

        return moves
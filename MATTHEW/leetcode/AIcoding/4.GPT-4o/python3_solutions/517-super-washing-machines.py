class Solution:
    def findMinMoves(self, machines: List[int]) -> int:
        total = sum(machines)
        n = len(machines)

        if total % n != 0:
            return -1

        target = total // n
        max_moves = 0
        current_sum = 0

        for m in machines:
            current_sum += m - target
            max_moves = max(max_moves, abs(current_sum), m - target)

        return max_moves
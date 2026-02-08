class Solution:
    def findMinMoves(self, machines: List[int]) -> int:
        total = sum(machines)
        n = len(machines)
        if total % n != 0:
            return -1
        avg = total // n
        res = 0
        balance = 0
        for num in machines:
            balance += num - avg
            res = max(res, abs(balance), num - avg)
        return res
class Solution:
    def findMinMoves(self, machines: List[int]) -> int:
        total = sum(machines)
        n = len(machines)
        if total % n != 0:
            return -1

        avg = total // n
        ans = 0
        curr = 0

        for i in range(n):
            curr += machines[i] - avg
            ans = max(ans, abs(curr), machines[i] - avg)

        return ans
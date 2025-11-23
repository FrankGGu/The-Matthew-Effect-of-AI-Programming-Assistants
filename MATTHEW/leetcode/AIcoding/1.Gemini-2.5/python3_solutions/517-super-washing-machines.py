class Solution:
    def superWashingMachines(self, machines: list[int]) -> int:
        n = len(machines)
        total_dresses = sum(machines)

        if total_dresses % n != 0:
            return -1

        avg_dresses = total_dresses // n

        ans = 0
        balance = 0
        for dresses in machines:
            diff = dresses - avg_dresses
            balance += diff
            ans = max(ans, abs(balance), diff)

        return ans
class Solution:
    def maxPower(self, stations: list[int], r: int, k: int) -> int:
        n = len(stations)
        def check(power):
            need = 0
            curr = 0
            delta = [0] * n
            for i in range(n):
                curr += delta[i] if i < n else 0
                power_needed = power - (stations[i] + curr)
                if power_needed > 0:
                    need += power_needed
                    if need > k:
                        return False
                    curr += power_needed
                    if i + 2 * r + 1 < n:
                        delta[i + 2 * r + 1] = -power_needed
            return need <= k

        left, right = min(stations), sum(stations) + k
        while left < right:
            mid = (left + right + 1) // 2
            if check(mid):
                left = mid
            else:
                right = mid - 1
        return left
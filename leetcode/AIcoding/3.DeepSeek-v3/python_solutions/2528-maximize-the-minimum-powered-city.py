class Solution:
    def maxPower(self, stations: List[int], r: int, k: int) -> int:
        n = len(stations)
        prefix = [0] * (n + 1)
        for i in range(n):
            left = max(0, i - r)
            right = min(n - 1, i + r)
            prefix[left] += stations[i]
            if right + 1 < n:
                prefix[right + 1] -= stations[i]

        current = 0
        power = []
        for i in range(n):
            current += prefix[i]
            power.append(current)

        low = min(power)
        high = low + k

        def is_possible(target):
            diff = [0] * (n + 1)
            current = 0
            used = 0
            for i in range(n):
                current += diff[i]
                needed = max(0, target - (power[i] + current))
                if needed > 0:
                    if used + needed > k:
                        return False
                    used += needed
                    current += needed
                    right = min(n - 1, i + r)
                    if right + 1 < n:
                        diff[right + 1] -= needed
            return used <= k

        answer = low
        while low <= high:
            mid = (low + high) // 2
            if is_possible(mid):
                answer = mid
                low = mid + 1
            else:
                high = mid - 1
        return answer
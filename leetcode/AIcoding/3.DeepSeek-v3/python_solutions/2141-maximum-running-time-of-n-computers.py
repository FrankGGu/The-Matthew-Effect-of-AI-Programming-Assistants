class Solution:
    def maxRunTime(self, n: int, batteries: List[int]) -> int:
        left, right = 1, sum(batteries) // n

        def canRun(time):
            total = 0
            for b in batteries:
                total += min(b, time)
                if total >= time * n:
                    return True
            return total >= time * n

        answer = 0
        while left <= right:
            mid = (left + right) // 2
            if canRun(mid):
                answer = mid
                left = mid + 1
            else:
                right = mid - 1
        return answer
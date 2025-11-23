class Solution:
    def minTime(self, time: List[int], m: int) -> int:
        left, right = 0, sum(time)

        def can_finish(max_time):
            days = 1
            current_sum = 0
            current_max = 0
            for t in time:
                current_sum += t
                current_max = max(current_max, t)
                if current_sum - current_max > max_time:
                    days += 1
                    current_sum = t
                    current_max = t
                    if days > m:
                        return False
            return days <= m

        while left < right:
            mid = (left + right) // 2
            if can_finish(mid):
                right = mid
            else:
                left = mid + 1
        return left
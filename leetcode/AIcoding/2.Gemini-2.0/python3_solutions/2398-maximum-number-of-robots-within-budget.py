from collections import deque

class Solution:
    def maximumRobots(self, chargeTimes: list[int], runningCosts: list[int], budget: int) -> int:
        n = len(chargeTimes)
        left = 0
        right = 0
        max_length = 0
        current_sum = 0
        max_charge_time_queue = deque()

        while right < n:
            current_sum += runningCosts[right]

            while max_charge_time_queue and chargeTimes[max_charge_time_queue[-1]] <= chargeTimes[right]:
                max_charge_time_queue.pop()
            max_charge_time_queue.append(right)

            while chargeTimes[max_charge_time_queue[0]] + current_sum * (right - left + 1) > budget:
                current_sum -= runningCosts[left]
                if max_charge_time_queue[0] == left:
                    max_charge_time_queue.popleft()
                left += 1

            max_length = max(max_length, right - left + 1)
            right += 1

        return max_length
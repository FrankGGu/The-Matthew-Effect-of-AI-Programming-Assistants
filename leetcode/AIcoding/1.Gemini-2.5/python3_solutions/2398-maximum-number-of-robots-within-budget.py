import collections

class Solution:
    def maximumRobots(self, chargeTimes: list[int], runningCosts: list[int], budget: int) -> int:
        n = len(chargeTimes)
        left = 0
        current_sum_running_cost = 0
        max_robots = 0

        monotonic_deque = collections.deque() # Stores indices of chargeTimes in decreasing order

        for right in range(n):
            current_sum_running_cost += runningCosts[right]

            while monotonic_deque and chargeTimes[monotonic_deque[-1]] <= chargeTimes[right]:
                monotonic_deque.pop()
            monotonic_deque.append(right)

            k = right - left + 1
            current_max_charge_time = chargeTimes[monotonic_deque[0]]
            current_cost = current_max_charge_time + current_sum_running_cost * k

            while current_cost > budget:
                current_sum_running_cost -= runningCosts[left]

                if monotonic_deque[0] == left:
                    monotonic_deque.popleft()

                left += 1

                k = right - left + 1

                if left > right: 
                    # If left pointer crosses right, the window is empty or invalid.
                    # This means even a single robot at 'right' is too expensive,
                    # or the window has been completely shrunk.
                    break 

                current_max_charge_time = chargeTimes[monotonic_deque[0]]
                current_cost = current_max_charge_time + current_sum_running_cost * k

            if left <= right: # Only update max_robots if a valid window exists
                max_robots = max(max_robots, k)

        return max_robots
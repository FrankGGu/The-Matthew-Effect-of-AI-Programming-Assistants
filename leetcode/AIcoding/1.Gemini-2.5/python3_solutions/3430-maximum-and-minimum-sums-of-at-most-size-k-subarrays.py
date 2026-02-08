import collections

class Solution:
    def solve(self, nums: list[int], k: int) -> list[int]:
        n = len(nums)

        # Calculate prefix sums
        # P[i] = sum(nums[0...i-1])
        # P[0] = 0
        P = [0] * (n + 1)
        for i in range(n):
            P[i+1] = P[i] + nums[i]

        max_sum = -float('inf')
        min_sum = float('inf')

        # Deque for maximum sum subarray (maintains increasing P[j] values)
        # We want to maximize P[i] - P[j], so we need to find minimum P[j]
        # in the valid window [max(0, i-k), i-1].
        deque_max = collections.deque()
        deque_max.append(0) # Index 0 for P[0]

        for i in range(1, n + 1):
            # Remove indices from the front that are too old (out of window i-k)
            # The valid range for j is [max(0, i-k), i-1]
            while deque_max and deque_max[0] < i - k:
                deque_max.popleft()

            # Calculate current max sum ending at i
            # P[i] - P[deque_max[0]] represents sum of subarray nums[deque_max[0]...i-1]
            max_sum = max(max_sum, P[i] - P[deque_max[0]])

            # Maintain monotonic increasing property for P values in deque
            # Remove indices from the back if their P value is >= current P[i]
            # because P[i] is a better candidate (smaller value, and newer)
            while deque_max and P[deque_max[-1]] >= P[i]:
                deque_max.pop()

            deque_max.append(i)

        # Deque for minimum sum subarray (maintains decreasing P[j] values)
        # We want to minimize P[i] - P[j], so we need to find maximum P[j]
        # in the valid window [max(0, i-k), i-1].
        deque_min = collections.deque()
        deque_min.append(0) # Index 0 for P[0]

        for i in range(1, n + 1):
            # Remove indices from the front that are too old
            while deque_min and deque_min[0] < i - k:
                deque_min.popleft()

            # Calculate current min sum ending at i
            min_sum = min(min_sum, P[i] - P[deque_min[0]])

            # Maintain monotonic decreasing property for P values in deque
            # Remove indices from the back if their P value is <= current P[i]
            # because P[i] is a better candidate (larger value, and newer)
            while deque_min and P[deque_min[-1]] <= P[i]:
                deque_min.pop()

            deque_min.append(i)

        return [max_sum, min_sum]
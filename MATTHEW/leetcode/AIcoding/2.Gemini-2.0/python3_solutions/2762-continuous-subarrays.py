class Solution:
    def continuousSubarrays(self, nums: List[int]) -> int:
        count = 0
        l = 0
        from collections import deque
        min_queue = deque()
        max_queue = deque()

        for r in range(len(nums)):
            while min_queue and nums[min_queue[-1]] >= nums[r]:
                min_queue.pop()
            min_queue.append(r)

            while max_queue and nums[max_queue[-1]] <= nums[r]:
                max_queue.pop()
            max_queue.append(r)

            while nums[max_queue[0]] - nums[min_queue[0]] > 2:
                l += 1
                if min_queue[0] < l:
                    min_queue.popleft()
                if max_queue[0] < l:
                    max_queue.popleft()

            count += (r - l + 1)
        return count
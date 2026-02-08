import heapq

class Solution:
    def kSum(self, nums: List[int], k: int) -> int:
        total_sum = 0
        positive_nums = []
        for num in nums:
            if num > 0:
                total_sum += num
                positive_nums.append(num)
            else:
                positive_nums.append(-num)
        positive_nums.sort()

        min_heap = [(total_sum - positive_nums[0], 0)]

        for _ in range(k - 1):
            curr_sum, curr_index = heapq.heappop(min_heap)

            if curr_index + 1 < len(positive_nums):
                heapq.heappush(min_heap, (curr_sum + positive_nums[curr_index] - positive_nums[curr_index + 1], curr_index + 1))
                heapq.heappush(min_heap, (curr_sum - positive_nums[curr_index + 1], curr_index + 1))

        return heapq.heappop(min_heap)[0]
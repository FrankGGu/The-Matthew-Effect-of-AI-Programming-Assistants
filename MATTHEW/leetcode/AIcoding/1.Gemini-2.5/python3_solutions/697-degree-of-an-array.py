class Solution:
    def findShortestSubArray(self, nums: list[int]) -> int:

        num_info = {} # {num: [count, first_index, last_index]}

        for i, num in enumerate(nums):
            if num not in num_info:
                num_info[num] = [1, i, i]
            else:
                num_info[num][0] += 1
                num_info[num][2] = i

        degree = 0
        min_length = float('inf')

        for count, first_idx, last_idx in num_info.values():
            if count > degree:
                degree = count
                min_length = last_idx - first_idx + 1
            elif count == degree:
                min_length = min(min_length, last_idx - first_idx + 1)

        return min_length
class Solution:
    def minimumSum(self, nums: List[int]) -> int:
        n = len(nums)
        left_min = [float('inf')] * n
        right_min = [float('inf')] * n

        min_so_far = float('inf')
        for i in range(n):
            if nums[i] > min_so_far:
                left_min[i] = min_so_far
            min_so_far = min(min_so_far, nums[i])

        min_so_far = float('inf')
        for i in range(n-1, -1, -1):
            if nums[i] > min_so_far:
                right_min[i] = min_so_far
            min_so_far = min(min_so_far, nums[i])

        min_sum = float('inf')
        for i in range(n):
            if left_min[i] != float('inf') and right_min[i] != float('inf'):
                current_sum = left_min[i] + nums[i] + right_min[i]
                if current_sum < min_sum:
                    min_sum = current_sum

        return min_sum if min_sum != float('inf') else -1
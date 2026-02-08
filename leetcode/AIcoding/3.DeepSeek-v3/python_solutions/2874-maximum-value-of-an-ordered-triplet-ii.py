class Solution:
    def maximumTripletValue(self, nums: List[int]) -> int:
        n = len(nums)
        left_max = [0] * n
        left_max[0] = nums[0]
        for i in range(1, n):
            left_max[i] = max(left_max[i-1], nums[i])

        right_max = [0] * n
        right_max[-1] = nums[-1]
        for i in range(n-2, -1, -1):
            right_max[i] = max(right_max[i+1], nums[i])

        max_value = 0
        for j in range(1, n-1):
            current = (left_max[j-1] - nums[j]) * right_max[j+1]
            if current > max_value:
                max_value = current

        return max_value if max_value > 0 else 0
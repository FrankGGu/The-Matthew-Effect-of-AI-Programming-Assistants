class Solution:
    def nodesBetweenCriticalPoints(self, nums: List[int]) -> List[int]:
        critical_points = []
        for i in range(1, len(nums) - 1):
            if (nums[i] > nums[i - 1] and nums[i] > nums[i + 1]) or \
               (nums[i] < nums[i - 1] and nums[i] < nums[i + 1]):
                critical_points.append(i)

        if len(critical_points) < 2:
            return [-1, -1]

        min_dist = float('inf')
        for i in range(1, len(critical_points)):
            min_dist = min(min_dist, critical_points[i] - critical_points[i - 1])

        max_dist = critical_points[-1] - critical_points[0]

        return [min_dist, max_dist]
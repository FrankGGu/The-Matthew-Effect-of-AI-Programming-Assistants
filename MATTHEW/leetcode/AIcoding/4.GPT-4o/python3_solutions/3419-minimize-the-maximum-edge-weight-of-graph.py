class Solution:
    def minimizeMax(self, nums: List[int], edges: int) -> int:
        def canFormGraph(maxWeight):
            count = 0
            n = len(nums)
            for i in range(n):
                for j in range(i + 1, n):
                    if abs(nums[i] - nums[j]) <= maxWeight:
                        count += 1
                    if count >= edges:
                        return True
            return count >= edges

        left, right = 0, max(nums) - min(nums)
        while left < right:
            mid = (left + right) // 2
            if canFormGraph(mid):
                right = mid
            else:
                left = mid + 1
        return left
class Solution:
    def minimizeMax(self, nums: List[int], p: int) -> int:
        nums.sort()
        n = len(nums)

        def count_pairs(threshold):
            count = 0
            i = 0
            while i < n - 1:
                if nums[i+1] - nums[i] <= threshold:
                    count += 1
                    i += 2
                else:
                    i += 1
            return count

        left, right = 0, nums[-1] - nums[0]
        ans = right

        while left <= right:
            mid = (left + right) // 2
            if count_pairs(mid) >= p:
                ans = mid
                right = mid - 1
            else:
                left = mid + 1

        return ans
class Solution:
    def smallestDistancePair(self, nums: list[int], k: int) -> int:
        nums.sort()
        n = len(nums)

        # Function to count pairs with distance <= mid
        def count_le_mid(mid_val: int) -> int:
            count = 0
            left = 0
            for right in range(n):
                while nums[right] - nums[left] > mid_val:
                    left += 1
                count += (right - left)
            return count

        low = 0
        high = nums[n - 1] - nums[0]
        ans = high

        while low <= high:
            mid = low + (high - low) // 2

            if count_le_mid(mid) >= k:
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans
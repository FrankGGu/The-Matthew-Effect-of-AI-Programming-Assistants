class Solution:
    def reversePairs(self, nums: List[int]) -> int:
        def merge_sort(nums):
            if len(nums) < 2:
                return 0
            mid = len(nums) // 2
            count = merge_sort(nums[:mid]) + merge_sort(nums[mid:])
            j = mid
            for i in range(len(nums[:mid])):
                while j < len(nums) and nums[i] > 2 * nums[j]:
                    j += 1
                count += j - mid
            nums[:] = sorted(nums)
            return count

        return merge_sort(nums)
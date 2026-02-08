class Solution:
    def numberOfPairs(self, nums1: List[int], nums2: List[int], diff: int) -> int:
        nums = [nums1[i] - nums2[i] for i in range(len(nums1))]
        count = 0
        sorted_nums = []

        for num in nums:
            l, r = 0, len(sorted_nums) - 1
            idx = len(sorted_nums)
            while l <= r:
                mid = (l + r) // 2
                if sorted_nums[mid] <= num + diff:
                    l = mid + 1
                else:
                    r = mid - 1
                    idx = mid
            count += len(sorted_nums) - idx

            l, r = 0, len(sorted_nums) - 1
            idx = len(sorted_nums)
            while l <= r:
                mid = (l + r) // 2
                if sorted_nums[mid] < num:
                    l = mid + 1
                else:
                    r = mid - 1
                    idx = mid
            sorted_nums.insert(idx, num)

        return count
class Solution:
    def minOperations(self, nums1: List[int], nums2: List[int]) -> int:
        sum1, sum2 = sum(nums1), sum(nums2)
        if sum1 == sum2:
            return 0
        if sum1 > sum2:
            nums1, nums2 = nums2, nums1
            sum1, sum2 = sum2, sum1

        diff = sum2 - sum1
        count = [0] * 7

        for num in nums1:
            count[num] += 1
        for num in nums2:
            count[6 - num] += 1

        operations = 0

        for i in range(6, 0, -1):
            while count[i] > 0 and diff > 0:
                diff -= i
                count[i] -= 1
                operations += 1

        return operations if diff <= 0 else -1
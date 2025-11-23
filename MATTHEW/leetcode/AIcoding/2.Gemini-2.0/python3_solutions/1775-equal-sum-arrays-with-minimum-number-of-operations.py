class Solution:
    def minOperations(self, nums1: list[int], nums2: list[int]) -> int:
        sum1, sum2 = sum(nums1), sum(nums2)
        if sum1 > sum2:
            nums1, nums2 = nums2, nums1
            sum1, sum2 = sum2, sum1

        if len(nums1) > 6 * len(nums2):
            return -1

        diff = sum2 - sum1
        if diff <= 0:
            return 0

        counts1 = [0] * 6
        counts2 = [0] * 6

        for num in nums1:
            counts1[num - 1] += 1
        for num in nums2:
            counts2[6 - num] += 1

        counts = [0] * 6
        for i in range(6):
            counts[i] = counts1[i] + counts2[i]

        operations = 0
        i = 5
        while diff > 0 and i > 0:
            num_to_reduce = min(counts[i], (diff + i) // (i))
            diff -= num_to_reduce * i
            operations += num_to_reduce
            i -= 1

        if diff > 0:
            operations += diff

        return operations
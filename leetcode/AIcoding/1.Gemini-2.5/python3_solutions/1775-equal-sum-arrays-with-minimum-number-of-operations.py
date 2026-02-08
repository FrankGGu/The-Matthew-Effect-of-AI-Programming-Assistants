class Solution:
    def minOperations(self, nums1: list[int], nums2: list[int]) -> int:
        len1, len2 = len(nums1), len(nums2)

        if len1 > 6 * len2 or len2 > 6 * len1:
            return -1

        s1 = sum(nums1)
        s2 = sum(nums2)

        if s1 == s2:
            return 0

        if s2 > s1:
            nums1, nums2 = nums2, nums1
            s1, s2 = s2, s1

        diff = s1 - s2
        operations = 0

        gains = []
        for x in nums1:
            gains.append(x - 1)
        for x in nums2:
            gains.append(6 - x)

        gains.sort(reverse=True)

        for gain in gains:
            if diff <= 0:
                break
            diff -= gain
            operations += 1

        return operations
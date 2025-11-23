class Solution:
    def minCost(self, nums1: List[int], nums2: List[int]) -> int:
        n = len(nums1)
        diff = []
        for i in range(n):
            if nums1[i] != nums2[i]:
                diff.append(abs(nums1[i] - nums2[i]))

        if not diff:
            return 0

        diff.sort()

        m = len(diff)

        median1 = diff[m // 2]
        median2 = diff[(m - 1) // 2]

        cost1 = 0
        cost2 = 0

        for val in diff:
            cost1 += abs(val - median1)
            cost2 += abs(val - median2)

        return min(cost1, cost2)
class Solution:
    def minOperations(self, nums1: list[int], nums2: list[int]) -> int:
        from collections import defaultdict

        diff = defaultdict(int)
        for a, b in zip(nums1, nums2):
            if a > b:
                diff[a - b] += 1
            elif a < b:
                diff[b - a] -= 1

        operations = 0
        for key in sorted(diff.keys(), reverse=True):
            count = diff[key]
            if count > 0:
                operations += count
            elif count < 0:
                operations += abs(count)

        return operations
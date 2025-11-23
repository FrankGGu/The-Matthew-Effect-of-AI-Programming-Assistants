class Solution:
    def maximumsSplicedArray(self, nums1: list[int], nums2: list[int]) -> int:

        def kadane(arr: list[int]) -> int:
            max_so_far = arr[0]
            current_max = arr[0]

            for i in range(1, len(arr)):
                current_max = max(arr[i], current_max + arr[i])
                max_so_far = max(max_so_far, current_max)

            return max_so_far

        sum1 = sum(nums1)
        sum2 = sum(nums2)
        n = len(nums1)

        diff1 = [nums2[i] - nums1[i] for i in range(n)]
        max_gain1 = kadane(diff1)

        diff2 = [nums1[i] - nums2[i] for i in range(n)]
        max_gain2 = kadane(diff2)

        return max(sum1 + max(0, max_gain1), sum2 + max(0, max_gain2))
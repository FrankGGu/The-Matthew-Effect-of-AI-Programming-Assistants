import bisect

class Solution:
    def minAbsDifference(self, nums: list[int], goal: int) -> int:
        n = len(nums)

        def generate_sums(arr):
            all_sums = []
            m = len(arr)

            def backtrack(index, current_sum):
                if index == m:
                    all_sums.append(current_sum)
                    return
                backtrack(index + 1, current_sum + arr[index])
                backtrack(index + 1, current_sum)

            backtrack(0, 0)
            return all_sums

        mid = n // 2
        nums1 = nums[:mid]
        nums2 = nums[mid:]

        sums1 = generate_sums(nums1)
        sums2 = generate_sums(nums2)

        sums2.sort()

        min_diff = abs(goal)

        for s1 in sums1:
            target_s2 = goal - s1

            idx = bisect.bisect_left(sums2, target_s2)

            if idx < len(sums2):
                current_sum = s1 + sums2[idx]
                min_diff = min(min_diff, abs(current_sum - goal))

            if idx > 0:
                current_sum = s1 + sums2[idx - 1]
                min_diff = min(min_diff, abs(current_sum - goal))

            if min_diff == 0:
                return 0

        return min_diff
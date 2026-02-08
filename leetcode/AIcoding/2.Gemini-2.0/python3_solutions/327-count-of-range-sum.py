class Solution:
    def countRangeSum(self, nums: list[int], lower: int, upper: int) -> int:
        n = len(nums)
        prefix_sums = [0] * (n + 1)
        for i in range(n):
            prefix_sums[i + 1] = prefix_sums[i] + nums[i]

        def merge_sort(left, right):
            if left >= right:
                return 0

            mid = (left + right) // 2
            count = merge_sort(left, mid) + merge_sort(mid + 1, right)

            i = left
            j = mid + 1
            lower_bound = mid + 1
            upper_bound = mid + 1

            while i <= mid:
                while lower_bound <= right and prefix_sums[lower_bound] - prefix_sums[i] < lower:
                    lower_bound += 1
                while upper_bound <= right and prefix_sums[upper_bound] - prefix_sums[i] <= upper:
                    upper_bound += 1
                count += upper_bound - lower_bound
                i += 1

            prefix_sums[left:right + 1] = sorted(prefix_sums[left:right + 1])
            return count

        return merge_sort(0, n)
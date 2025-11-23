class Solution:
    def minimumDifference(self, nums: List[int]) -> int:
        n = len(nums) // 2
        left = []
        right = []

        for mask in range(1 << n):
            sum_left = sum(nums[i] for i in range(n) if mask & (1 << i))
            left.append(sum_left)

        for mask in range(1 << n):
            sum_right = sum(nums[n + i] for i in range(n) if mask & (1 << i))
            right.append(sum_right)

        left.sort()
        right.sort()

        total_sum = sum(nums)
        min_diff = float('inf')

        for l in left:
            target = (total_sum // 2) - l
            lo, hi = 0, len(right) - 1

            while lo <= hi:
                mid = (lo + hi) // 2
                if right[mid] < target:
                    lo = mid + 1
                else:
                    hi = mid - 1

            if lo < len(right):
                min_diff = min(min_diff, abs(total_sum - 2 * (l + right[lo])))
            if hi >= 0:
                min_diff = min(min_diff, abs(total_sum - 2 * (l + right[hi])))

        return min_diff
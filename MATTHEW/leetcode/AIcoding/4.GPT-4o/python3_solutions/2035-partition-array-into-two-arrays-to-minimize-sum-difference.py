class Solution:
    def minimumDifference(self, nums: List[int]) -> int:
        total = sum(nums)
        n = len(nums) // 2
        first_half = nums[:n]
        second_half = nums[n:]

        sum1 = []
        for i in range(n + 1):
            for combo in combinations(first_half, i):
                sum1.append(sum(combo))

        sum2 = []
        for i in range(n + 1):
            for combo in combinations(second_half, i):
                sum2.append(sum(combo))

        sum1.sort()
        sum2.sort()

        min_diff = float('inf')

        for s1 in sum1:
            target = (total - 2 * s1) / 2
            l, r = 0, len(sum2) - 1

            while l <= r:
                mid = (l + r) // 2
                if sum2[mid] < target:
                    l = mid + 1
                else:
                    r = mid - 1

            if l < len(sum2):
                min_diff = min(min_diff, abs(total - 2 * (s1 + sum2[l])))
            if r >= 0:
                min_diff = min(min_diff, abs(total - 2 * (s1 + sum2[r])))

        return min_diff
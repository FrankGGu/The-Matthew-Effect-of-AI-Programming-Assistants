class Solution:
    def minimumDifference(self, nums: list[int]) -> int:
        n = len(nums) // 2
        total_sum = sum(nums)
        left = nums[:n]
        right = nums[n:]

        def generate_sums(arr):
            sums = [[] for _ in range(n + 1)]
            sums[0].append(0)
            for num in arr:
                for i in range(n, 0, -1):
                    for s in sums[i - 1]:
                        sums[i].append(s + num)
            for i in range(n + 1):
                sums[i].sort()
            return sums

        left_sums = generate_sums(left)
        right_sums = generate_sums(right)

        ans = float('inf')
        for i in range(n + 1):
            for left_sum in left_sums[i]:
                target = (total_sum // 2) - left_sum

                l, r = 0, len(right_sums[n - i]) - 1
                while l <= r:
                    mid = (l + r) // 2
                    right_sum = right_sums[n - i][mid]

                    ans = min(ans, abs(total_sum - 2 * (left_sum + right_sum)))

                    if right_sum < target:
                        l = mid + 1
                    else:
                        r = mid - 1

        return ans
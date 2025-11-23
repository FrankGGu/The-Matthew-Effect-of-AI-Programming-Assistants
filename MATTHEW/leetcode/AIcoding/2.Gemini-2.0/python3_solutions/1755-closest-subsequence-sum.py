class Solution:
    def minAbsDifference(self, nums: List[int], goal: int) -> int:
        def get_sums(arr):
            sums = {0}
            for num in arr:
                new_sums = set()
                for s in sums:
                    new_sums.add(s + num)
                sums.update(new_sums)
            return sorted(list(sums))

        n = len(nums)
        left_sums = get_sums(nums[:n // 2])
        right_sums = get_sums(nums[n // 2:])

        ans = float('inf')

        l, r = 0, len(right_sums) - 1
        while l < len(left_sums) and r >= 0:
            curr_sum = left_sums[l] + right_sums[r]
            ans = min(ans, abs(curr_sum - goal))
            if curr_sum > goal:
                r -= 1
            else:
                l += 1

        return ans
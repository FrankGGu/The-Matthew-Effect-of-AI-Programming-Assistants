import bisect

class Solution:
    def minPairRemovalToSortArrayI(self, nums: list[int]) -> int:
        if not nums:
            return 0

        tails = []
        for num in nums:
            idx = bisect.bisect_right(tails, num)
            if idx == len(tails):
                tails.append(num)
            else:
                tails[idx] = num

        lis_len = len(tails)

        removals = len(nums) - lis_len

        min_pair_removals = (removals + 1) // 2

        return min_pair_removals
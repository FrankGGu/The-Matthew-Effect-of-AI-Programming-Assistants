import bisect

class Solution:
    def minPairRemoval(self, nums: list[int]) -> int:
        n = len(nums)
        if n == 0:
            return 0

        tails = [] 
        for num in nums:
            idx = bisect.bisect_right(tails, num)
            if idx == len(tails):
                tails.append(num)
            else:
                tails[idx] = num

        lnds_length = len(tails)

        removed_elements_count = n - lnds_length

        if removed_elements_count % 2 == 0:
            return removed_elements_count // 2
        else:
            return (removed_elements_count + 1) // 2
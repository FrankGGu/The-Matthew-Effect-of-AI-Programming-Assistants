class Solution:
    def identifyOutlier(self, nums: List[int]) -> int:
        if len(nums) < 3:
            return -1

        even = []
        odd = []

        for num in nums:
            if num % 2 == 0:
                even.append(num)
            else:
                odd.append(num)

        if len(even) == 1:
            return max(even)
        elif len(odd) == 1:
            return max(odd)
        else:
            return -1
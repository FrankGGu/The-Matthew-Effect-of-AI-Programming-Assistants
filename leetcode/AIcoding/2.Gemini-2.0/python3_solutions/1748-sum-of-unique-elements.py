class Solution:
    def sumOfUnique(self, nums: List[int]) -> int:
        count = {}
        for num in nums:
            if num in count:
                count[num] += 1
            else:
                count[num] = 1

        sum_unique = 0
        for num, freq in count.items():
            if freq == 1:
                sum_unique += num

        return sum_unique
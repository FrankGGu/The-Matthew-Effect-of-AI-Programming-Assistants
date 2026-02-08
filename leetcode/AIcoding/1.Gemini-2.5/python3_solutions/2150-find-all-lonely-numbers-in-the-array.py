import collections

class Solution:
    def findLonely(self, nums: list[int]) -> list[int]:
        if not nums:
            return []

        counts = collections.Counter(nums)
        num_set = set(nums)

        lonely_numbers = []

        for num in nums:
            if counts[num] == 1:
                if (num - 1) not in num_set and \
                   (num + 1) not in num_set:
                    lonely_numbers.append(num)

        return lonely_numbers
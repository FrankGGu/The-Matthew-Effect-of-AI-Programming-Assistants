import collections

class Solution:
    def findMatrix(self, nums: list[int]) -> list[list[int]]:
        freq = collections.Counter(nums)

        max_freq = 0
        for count in freq.values():
            if count > max_freq:
                max_freq = count

        result = [[] for _ in range(max_freq)]

        for num, count in freq.items():
            for i in range(count):
                result[i].append(num)

        return result
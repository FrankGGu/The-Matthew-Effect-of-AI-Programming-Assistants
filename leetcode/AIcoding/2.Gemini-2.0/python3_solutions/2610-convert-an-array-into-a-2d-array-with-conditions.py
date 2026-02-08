from collections import Counter

class Solution:
    def findMatrix(self, nums: list[int]) -> list[list[int]]:
        count = Counter(nums)
        result = []
        while count:
            row = []
            to_remove = []
            for num, freq in count.items():
                row.append(num)
                count[num] -= 1
                if count[num] == 0:
                    to_remove.append(num)
            for num in to_remove:
                del count[num]
            result.append(row)
        return result
from collections import defaultdict

class Solution:
    def findDiagonalOrder(self, nums: List[List[int]]) -> List[int]:
        diagonals = defaultdict(list)
        for i in range(len(nums)):
            for j in range(len(nums[i])):
                diagonals[i + j].append(nums[i][j])

        result = []
        k = 0
        while k in diagonals:
            result.extend(diagonals[k][::-1])
            k += 1

        return result
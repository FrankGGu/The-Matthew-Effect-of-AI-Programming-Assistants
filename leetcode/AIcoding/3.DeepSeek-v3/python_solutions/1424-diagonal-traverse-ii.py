class Solution:
    def findDiagonalOrder(self, nums: List[List[int]]) -> List[int]:
        groups = defaultdict(list)
        for row in range(len(nums)):
            for col in range(len(nums[row])):
                diagonal = row + col
                groups[diagonal].append(nums[row][col])

        result = []
        for key in sorted(groups.keys()):
            result.extend(reversed(groups[key]))

        return result
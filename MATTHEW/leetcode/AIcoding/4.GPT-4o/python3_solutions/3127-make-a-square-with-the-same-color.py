class Solution:
    def canMakeSquare(self, nums: List[int]) -> bool:
        if sum(nums) % 4 != 0 or len(nums) < 4:
            return False
        side = sum(nums) // 4
        sides = [0] * 4

        def backtrack(index):
            if index == len(nums):
                return all(s == side for s in sides)
            for i in range(4):
                if sides[i] + nums[index] <= side:
                    sides[i] += nums[index]
                    if backtrack(index + 1):
                        return True
                    sides[i] -= nums[index]
                if sides[i] == 0:
                    break
            return False

        return backtrack(0)
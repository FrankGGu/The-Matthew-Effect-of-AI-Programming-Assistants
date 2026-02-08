class Solution:
    def minOperations(self, nums: List[int], target: int) -> int:
        total = sum(nums)
        if total < target:
            return -1

        nums.sort()
        res = 0
        i = 0
        while target > 0:
            num = nums[i] if i < len(nums) else 0
            if num <= target:
                target -= num
                if i < len(nums):
                    nums.pop(i)
            else:
                if num > 1:
                    nums.insert(i, num // 2)
                    nums.insert(i, num // 2)
                    res += 1
                else:
                    i += 1
        return res
class Solution:
    def minOperations(self, nums: List[int], target: int) -> int:
        nums.sort()
        operations = 0
        total = 0

        for num in nums:
            total += num
            if total >= target:
                break

        if total < target:
            return -1

        total = 0
        res = 0
        for num in nums:
            total += num
            if total > target:
                res += total - target
                total = target
            if total == target:
                break

        return res
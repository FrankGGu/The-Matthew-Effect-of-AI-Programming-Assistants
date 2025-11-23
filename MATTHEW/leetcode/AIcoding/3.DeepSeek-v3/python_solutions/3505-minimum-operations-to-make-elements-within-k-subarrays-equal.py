class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        target = set(nums[:k])
        current = set()
        res = 0

        for i in range(len(nums)-1, -1, -1):
            if nums[i] in target and nums[i] not in current:
                current.add(nums[i])
                res += 1
                if len(current) == len(target):
                    break

        return len(nums) - i
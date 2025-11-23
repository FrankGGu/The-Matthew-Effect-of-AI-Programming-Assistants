class Solution:
    def minOperations(self, nums: List[int], target: int) -> int:
        operations = 0
        carry = 0
        for i in range(len(nums)):
            num = nums[i]
            total = num + carry
            bit = total % 2
            if bit != (target >> i) & 1:
                operations += 1
                carry = 1
            else:
                carry = total // 2
        return operations
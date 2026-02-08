class Solution:
    def minOperations(self, nums: List[int]) -> int:
        operations = 0
        while True:
            # Check if all elements are zero
            all_zero = True
            for num in nums:
                if num != 0:
                    all_zero = False
                    break
            if all_zero:
                return operations

            # Check if any element is odd
            has_odd = False
            for i in range(len(nums)):
                if nums[i] % 2 != 0:
                    has_odd = True
                    nums[i] -= 1
                    operations += 1
            if has_odd:
                continue

            # All elements are even, divide by 2
            for i in range(len(nums)):
                nums[i] = nums[i] // 2
            operations += 1
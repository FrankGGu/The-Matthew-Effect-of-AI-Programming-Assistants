class Solution:
    def minimumOperations(self, nums: list[int], target: list[int]) -> int:
        nums_even = []
        nums_odd = []
        target_even = []
        target_odd = []

        for num in nums:
            if num % 2 == 0:
                nums_even.append(num)
            else:
                nums_odd.append(num)

        for num in target:
            if num % 2 == 0:
                target_even.append(num)
            else:
                target_odd.append(num)

        nums_even.sort()
        nums_odd.sort()
        target_even.sort()
        target_odd.sort()

        operations_sum = 0

        for i in range(len(nums_even)):
            operations_sum += abs(nums_even[i] - target_even[i])

        for i in range(len(nums_odd)):
            operations_sum += abs(nums_odd[i] - target_odd[i])

        return operations_sum // 2
class Solution:
    def minOperations(self, nums: list[int], k: int) -> int:
        collected_elements = set()
        operations_count = 0

        for i in range(len(nums) - 1, -1, -1):
            operations_count += 1
            current_num = nums[i]

            if 1 <= current_num <= k and current_num not in collected_elements:
                collected_elements.add(current_num)

            if len(collected_elements) == k:
                break

        return operations_count
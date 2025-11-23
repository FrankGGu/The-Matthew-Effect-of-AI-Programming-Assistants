class Solution:
    def sumEvenAfterQueries(self, nums: list[int], queries: list[list[int]]) -> list[int]:
        current_even_sum = 0
        for num in nums:
            if num % 2 == 0:
                current_even_sum += num

        results = []

        for val, index in queries:
            old_value = nums[index]

            if old_value % 2 == 0:
                current_even_sum -= old_value

            nums[index] += val
            new_value = nums[index]

            if new_value % 2 == 0:
                current_even_sum += new_value

            results.append(current_even_sum)

        return results
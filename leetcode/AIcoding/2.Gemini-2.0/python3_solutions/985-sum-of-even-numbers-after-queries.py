class Solution:
    def sumEvenAfterQueries(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        even_sum = 0
        for num in nums:
            if num % 2 == 0:
                even_sum += num

        result = []
        for val, index in queries:
            if nums[index] % 2 == 0:
                even_sum -= nums[index]

            nums[index] += val

            if nums[index] % 2 == 0:
                even_sum += nums[index]

            result.append(even_sum)

        return result
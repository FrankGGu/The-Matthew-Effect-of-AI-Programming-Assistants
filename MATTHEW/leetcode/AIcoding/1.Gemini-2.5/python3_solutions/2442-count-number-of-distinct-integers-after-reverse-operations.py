class Solution:
    def countDistinctIntegers(self, nums: List[int]) -> int:
        distinct_numbers = set(nums)

        for num in nums:
            reversed_num_str = str(num)[::-1]
            reversed_num = int(reversed_num_str)
            distinct_numbers.add(reversed_num)

        return len(distinct_numbers)
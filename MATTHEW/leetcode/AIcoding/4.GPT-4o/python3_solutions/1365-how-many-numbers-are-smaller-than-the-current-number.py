class Solution:
    def smallerNumbersThanCurrent(self, nums: List[int]) -> List[int]:
        sorted_nums = sorted(nums)
        num_to_index = {num: i for i, num in enumerate(sorted_nums)}
        return [num_to_index[num] for num in nums]
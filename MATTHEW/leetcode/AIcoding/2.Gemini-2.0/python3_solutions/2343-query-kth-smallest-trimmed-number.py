class Solution:
    def smallestTrimmedNumbers(self, nums: List[str], queries: List[List[int]]) -> List[int]:
        result = []
        for k, trim in queries:
            trimmed_nums = []
            for i, num in enumerate(nums):
                trimmed_num = num[-trim:]
                trimmed_nums.append((trimmed_num, i))

            trimmed_nums.sort(key=lambda x: x[0])
            result.append(trimmed_nums[k - 1][1])

        return result
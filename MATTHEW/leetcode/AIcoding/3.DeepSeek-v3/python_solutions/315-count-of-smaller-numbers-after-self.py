class Solution:
    def countSmaller(self, nums: List[int]) -> List[int]:
        import bisect
        sorted_nums = []
        result = []
        for num in reversed(nums):
            index = bisect.bisect_left(sorted_nums, num)
            result.append(index)
            bisect.insort(sorted_nums, num)
        return result[::-1]
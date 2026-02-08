class Solution:
    def canSortArray(self, nums: List[int]) -> bool:
        n = len(nums)
        bits = [num.bit_count() for num in nums]

        for i in range(n - 1):
            if nums[i] > nums[i + 1]:
                if bits[i] != bits[i + 1]:
                    return False

        return True
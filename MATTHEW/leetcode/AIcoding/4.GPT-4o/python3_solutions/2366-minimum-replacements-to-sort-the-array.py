class Solution:
    def minimumReplacement(self, nums: List[int]) -> int:
        n = len(nums)
        replacements = 0
        last = nums[-1]

        for i in range(n - 2, -1, -1):
            if nums[i] > last:
                count = (nums[i] + last - 1) // last
                replacements += count - 1
                last = nums[i] // count

        return replacements
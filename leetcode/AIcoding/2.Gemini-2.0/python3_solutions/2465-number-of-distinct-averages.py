class Solution:
    def distinctAverages(self, nums: List[int]) -> int:
        nums.sort()
        seen = set()
        l, r = 0, len(nums) - 1
        while l < r:
            avg = (nums[l] + nums[r]) / 2
            seen.add(avg)
            l += 1
            r -= 1
        return len(seen)
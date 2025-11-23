class Solution:
    def countFairPairs(self, nums: List[int], lower: int, upper: int) -> int:
        nums.sort()
        count = 0
        n = len(nums)

        def count_pairs(l, r):
            nonlocal count
            while l < r:
                total = nums[l] + nums[r]
                if total < lower:
                    l += 1
                elif total > upper:
                    r -= 1
                else:
                    count += r - l
                    return

        for i in range(n):
            count_pairs(i + 1, n - 1)

        return count
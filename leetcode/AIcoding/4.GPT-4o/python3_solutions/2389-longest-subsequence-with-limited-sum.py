class Solution:
    def maxLength(self, nums: List[int], limit: int) -> int:
        nums.sort()
        total, count = 0, 0
        for num in nums:
            if total + num <= limit:
                total += num
                count += 1
            else:
                break
        return count
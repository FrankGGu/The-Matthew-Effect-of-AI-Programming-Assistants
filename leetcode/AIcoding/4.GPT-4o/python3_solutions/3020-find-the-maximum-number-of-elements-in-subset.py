class Solution:
    def maxElements(self, nums: List[int], limit: int) -> int:
        nums.sort()
        count = 0
        total = 0
        for num in nums:
            if total + num <= limit:
                total += num
                count += 1
            else:
                break
        return count
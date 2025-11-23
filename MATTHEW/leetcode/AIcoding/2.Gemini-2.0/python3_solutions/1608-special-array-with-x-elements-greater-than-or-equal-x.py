class Solution:
    def specialArray(self, nums: List[int]) -> int:
        nums.sort(reverse=True)
        n = len(nums)
        for i in range(n + 1):
            count = 0
            for num in nums:
                if num >= i:
                    count += 1
                else:
                    break
            if count == i:
                return i
        return -1
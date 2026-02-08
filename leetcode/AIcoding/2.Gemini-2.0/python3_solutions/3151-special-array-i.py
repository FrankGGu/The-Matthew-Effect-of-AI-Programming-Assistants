class Solution:
    def specialArray(self, nums: List[int]) -> int:
        nums.sort(reverse=True)
        n = len(nums)
        for x in range(1, n + 1):
            count = 0
            for num in nums:
                if num >= x:
                    count += 1
                else:
                    break
            if count == x:
                return x
        return -1
class Solution:
    def wiggleSort(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        nums.sort()
        n = len(nums)
        mid = (n + 1) // 2
        temp = nums[mid:] + nums[:mid]
        for i in range(n):
            nums[i] = temp.pop() if i % 2 == 1 else temp.pop()
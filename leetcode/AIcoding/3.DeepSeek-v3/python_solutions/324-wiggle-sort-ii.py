class Solution:
    def wiggleSort(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        nums_sorted = sorted(nums)
        n = len(nums)
        mid = (n + 1) // 2
        left = nums_sorted[:mid][::-1]
        right = nums_sorted[mid:][::-1]

        j = 0
        for i in range(0, n, 2):
            nums[i] = left[j]
            if i + 1 < n:
                nums[i+1] = right[j]
            j += 1
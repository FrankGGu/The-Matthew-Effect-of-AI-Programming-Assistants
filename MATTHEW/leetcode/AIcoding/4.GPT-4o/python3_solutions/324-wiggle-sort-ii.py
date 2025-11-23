class Solution:
    def wiggleSort(self, nums: List[int]) -> None:
        n = len(nums)
        mid = sorted(nums)[(n - 1) // 2]

        def virtual_index(i):
            return (1 + 2 * i) % (n | 1)

        left, right, i = 0, n - 1, 0
        while i <= right:
            vi = virtual_index(i)
            if nums[vi] > mid:
                nums[virtual_index(left)], nums[vi] = nums[vi], nums[virtual_index(left)]
                left += 1
                i += 1
            elif nums[vi] < mid:
                nums[virtual_index(right)], nums[vi] = nums[vi], nums[virtual_index(right)]
                right -= 1
            else:
                i += 1
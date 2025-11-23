class Solution:
    def goodIndices(self, nums: List[int], k: int) -> List[int]:
        n = len(nums)
        left = [0] * n
        right = [0] * n

        for i in range(1, n):
            if nums[i] <= nums[i - 1]:
                left[i] = left[i - 1] + 1

        for i in range(n - 2, -1, -1):
            if nums[i] <= nums[i + 1]:
                right[i] = right[i + 1] + 1

        good_indices = []
        for i in range(k, n - k):
            if left[i - 1] >= k - 1 and right[i + 1] >= k - 1:
                good_indices.append(i)

        return good_indices
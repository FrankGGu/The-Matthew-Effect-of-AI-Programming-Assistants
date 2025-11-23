class Solution:
    def minimumRemovals(self, nums: List[int]) -> int:
        n = len(nums)
        left = [1] * n
        right = [1] * n

        for i in range(n):
            for j in range(i):
                if nums[j] < nums[i]:
                    left[i] = max(left[i], left[j] + 1)

        for i in range(n - 1, -1, -1):
            for j in range(n - 1, i, -1):
                if nums[j] < nums[i]:
                    right[i] = max(right[i], right[j] + 1)

        result = 0
        for i in range(n):
            if left[i] > 1 and right[i] > 1:
                result = max(result, left[i] + right[i] - 1)

        return n - result
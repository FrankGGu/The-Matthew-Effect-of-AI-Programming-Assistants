from typing import List

class Solution:
    def maxRotateFunction(self, nums: List[int]) -> int:
        n = len(nums)

        if n == 0:
            return 0

        current_F = 0
        for i in range(n):
            current_F += i * nums[i]

        total_sum = sum(nums)

        max_F = current_F

        for k in range(n - 1):
            # F(k+1) = F(k) + totalSum - n * nums[n - 1 - k]
            # nums[n - 1 - k] is the element that was at the last position (index n-1)
            # in the array corresponding to F(k), and moves to the first position (index 0)
            # in the array corresponding to F(k+1).
            # This element is A_k[n-1], which is nums[(n-1-k+n)%n] from the original array.
            # For k=0, it's nums[n-1].
            # For k=1, it's nums[n-2].
            # ...
            # For k=n-2, it's nums[1].

            current_F = current_F + total_sum - n * nums[n - 1 - k]
            max_F = max(max_F, current_F)

        return max_F
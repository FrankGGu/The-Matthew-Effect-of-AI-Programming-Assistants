class Solution:
    def countSubarrays(self, nums: List[int], k: int) -> int:
        n = len(nums)
        count = 0

        # Step 1: Find the index of k
        k_index = -1
        for i in range(n):
            if nums[i] == k:
                k_index = i
                break

        if k_index == -1:
            return 0

        # Step 2: Calculate count of subarrays
        left = right = 0

        # Count how many elements are greater than k on the left side
        for i in range(k_index - 1, -1, -1):
            if nums[i] > k:
                left += 1
            else:
                break

        # Count how many elements are greater than k on the right side
        for j in range(k_index + 1, n):
            if nums[j] > k:
                right += 1
            else:
                break

        # The total number of subarrays containing k as the median
        count = (left + 1) * (right + 1)

        # Add the contributions from the left side
        left_counts = 0
        for i in range(k_index - 1, -1, -1):
            if nums[i] < k:
                left_counts += 1
            else:
                break
            count += left_counts

        # Add the contributions from the right side
        right_counts = 0
        for j in range(k_index + 1, n):
            if nums[j] < k:
                right_counts += 1
            else:
                break
            count += right_counts

        return count
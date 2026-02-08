class Solution:
    def numberOfSubarrays(self, nums: List[int], k: int) -> int:
        odd_indices = [-1]
        for i, num in enumerate(nums):
            if num % 2 != 0:
                odd_indices.append(i)
        odd_indices.append(len(nums))

        count = 0
        for i in range(1, len(odd_indices) - k):
            count += (odd_indices[i] - odd_indices[i - 1]) * (odd_indices[i + k] - odd_indices[i + k - 1])
        return count
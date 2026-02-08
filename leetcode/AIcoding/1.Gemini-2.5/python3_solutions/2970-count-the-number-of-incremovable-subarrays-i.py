class Solution:
    def incremovableSubarrayCount(self, nums: list[int]) -> int:
        n = len(nums)
        count = 0

        for i in range(n):
            for j in range(i, n):
                is_valid = True

                # Check the prefix part: nums[0...i-1]
                for k in range(i - 1):
                    if nums[k] >= nums[k+1]:
                        is_valid = False
                        break
                if not is_valid:
                    continue

                # Check the suffix part: nums[j+1...n-1]
                for k in range(j + 1, n - 1):
                    if nums[k] >= nums[k+1]:
                        is_valid = False
                        break
                if not is_valid:
                    continue

                # Check the connection between prefix and suffix
                # This applies only if both prefix and suffix exist
                if i > 0 and j < n - 1:
                    if nums[i-1] >= nums[j+1]:
                        is_valid = False

                if is_valid:
                    count += 1

        return count
class Solution:
    def incremovableSubarrayCount(self, nums: List[int]) -> int:
        n = len(nums)
        count = 0

        for i in range(n):
            for j in range(i, n):
                valid = True
                # Check the remaining part after removing subarray nums[i..j]
                remaining = nums[:i] + nums[j+1:]
                for k in range(len(remaining) - 1):
                    if remaining[k] >= remaining[k+1]:
                        valid = False
                        break
                if valid:
                    count += 1

        return count
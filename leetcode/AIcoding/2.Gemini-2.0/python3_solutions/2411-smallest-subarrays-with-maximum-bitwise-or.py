class Solution:
    def smallestSubarrays(self, nums: List[int]) -> List[int]:
        n = len(nums)
        ans = [1] * n
        for i in range(n):
            max_or = nums[i]
            right = i
            for j in range(i + 1, n):
                max_or |= nums[j]
                if max_or == (nums[i] | (0 if i == j else nums[i+1:j+1][0] if len(nums[i+1:j+1])>0 else 0) | (0 if i == j else nums[i+1:j+1][-1] if len(nums[i+1:j+1])>0 else 0)):
                    right = j
                else:
                    break

            max_or = nums[i]
            right = i
            for j in range(i, n):
                max_or |= nums[j]
                if max_or == (nums[i] | (0 if i == j else nums[i+1:j+1][0] if len(nums[i+1:j+1])>0 else 0) | (0 if i == j else nums[i+1:j+1][-1] if len(nums[i+1:j+1])>0 else 0)):
                   right = j
                else:
                   break
            ans[i] = right - i + 1
        return ans
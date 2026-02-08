class Solution:
    def getMinSwaps(self, num: str, k: int) -> int:
        def next_permutation(nums):
            n = len(nums)
            i = n - 2
            while i >= 0 and nums[i] >= nums[i + 1]:
                i -= 1
            if i >= 0:
                j = n - 1
                while j >= 0 and nums[j] <= nums[i]:
                    j -= 1
                nums[i], nums[j] = nums[j], nums[i]
            left, right = i + 1, n - 1
            while left < right:
                nums[left], nums[right] = nums[right], nums[left]
                left += 1
                right -= 1
            return nums

        original = list(num)
        permuted = list(num)
        for _ in range(k):
            permuted = next_permutation(permuted)

        res = 0
        for i in range(len(original)):
            if original[i] != permuted[i]:
                j = i + 1
                while j < len(original) and original[j] != permuted[i]:
                    j += 1
                res += j - i
                original[i + 1:j + 1] = original[i:j]
        return res
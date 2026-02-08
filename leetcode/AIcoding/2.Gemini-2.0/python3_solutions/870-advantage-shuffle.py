class Solution:
    def advantageCount(self, nums1: list[int], nums2: list[int]) -> list[int]:
        n = len(nums1)
        nums1.sort()
        idx = sorted(range(n), key=lambda i: nums2[i])
        ans = [0] * n
        left, right = 0, n - 1
        for num in nums1:
            if num > nums2[idx[left]]:
                ans[idx[left]] = num
                left += 1
            else:
                ans[idx[right]] = num
                right -= 1
        return ans
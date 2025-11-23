class Solution:
    def maxNumber(self, nums1: list[int], nums2: list[int], k: int) -> list[int]:
        def pick_max(nums, k):
            stack = []
            drop = len(nums) - k
            for num in nums:
                while stack and drop > 0 and stack[-1] < num:
                    stack.pop()
                    drop -= 1
                stack.append(num)
            return stack[:k]

        def merge(nums1, nums2):
            res = []
            i, j = 0, 0
            while i < len(nums1) or j < len(nums2):
                if nums1[i:] > nums2[j:]:
                    res.append(nums1[i])
                    i += 1
                else:
                    res.append(nums2[j])
                    j += 1
            return res

        res = []
        for i in range(max(0, k - len(nums2)), min(k, len(nums1)) + 1):
            nums1_picked = pick_max(nums1, i)
            nums2_picked = pick_max(nums2, k - i)
            merged = merge(nums1_picked, nums2_picked)
            res = max(res, merged)
        return res
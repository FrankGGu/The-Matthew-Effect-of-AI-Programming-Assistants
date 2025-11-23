class Solution:
    def maxNumber(self, nums1: List[int], nums2: List[int], k: int) -> List[int]:
        def maxSingle(nums, k):
            stack = []
            drop = len(nums) - k
            for num in nums:
                while drop > 0 and stack and stack[-1] < num:
                    stack.pop()
                    drop -= 1
                stack.append(num)
            return stack[:k]

        def merge(a, b):
            res = []
            while a or b:
                bigger = a if a > b else b
                res.append(bigger[0])
                bigger.pop(0)
            return res

        max_res = []
        for i in range(max(0, k - len(nums2)), min(k, len(nums1)) + 1):
            candidate = merge(maxSingle(nums1, i), maxSingle(nums2, k - i))
            if candidate > max_res:
                max_res = candidate
        return max_res
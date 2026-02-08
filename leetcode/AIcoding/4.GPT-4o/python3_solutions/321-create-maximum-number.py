class Solution:
    def maxNumber(self, nums1: List[int], nums2: List[int], k: int) -> List[int]:
        def get_max_array(nums, length):
            stack = []
            drop = len(nums) - length
            for num in nums:
                while drop and stack and stack[-1] < num:
                    stack.pop()
                    drop -= 1
                stack.append(num)
            return stack[:length]

        def merge(arr1, arr2):
            return [max(arr1, arr2).pop(0) for _ in range(len(arr1) + len(arr2))]

        max_result = []
        for i in range(max(0, k - len(nums2)), min(k, len(nums1)) + 1):
            max1 = get_max_array(nums1, i)
            max2 = get_max_array(nums2, k - i)
            max_result = max(max_result, merge(max1, max2))

        return max_result
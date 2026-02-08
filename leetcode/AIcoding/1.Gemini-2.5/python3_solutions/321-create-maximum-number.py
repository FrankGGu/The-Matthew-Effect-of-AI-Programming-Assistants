from typing import List

class Solution:
    def maxNumber(self, nums1: List[int], nums2: List[int], k: int) -> List[int]:

        def max_array(nums: List[int], k_len: int) -> List[int]:
            stack = []
            to_drop = len(nums) - k_len
            for num in nums:
                while stack and num > stack[-1] and to_drop > 0:
                    stack.pop()
                    to_drop -= 1
                stack.append(num)
            return stack[:k_len]

        def merge(arr1: List[int], arr2: List[int]) -> List[int]:
            res = []
            i, j = 0, 0
            while i < len(arr1) or j < len(arr2):
                if i < len(arr1) and j < len(arr2):
                    if arr1[i:] > arr2[j:]:
                        res.append(arr1[i])
                        i += 1
                    else:
                        res.append(arr2[j])
                        j += 1
                elif i < len(arr1):
                    res.extend(arr1[i:])
                    break
                else: # j < len(arr2)
                    res.extend(arr2[j:])
                    break
            return res

        max_overall_num = []

        for i in range(max(0, k - len(nums2)), min(k, len(nums1)) + 1):
            j = k - i

            arr1_max = max_array(nums1, i)
            arr2_max = max_array(nums2, j)

            merged_num = merge(arr1_max, arr2_max)

            if not max_overall_num or merged_num > max_overall_num:
                max_overall_num = merged_num

        return max_overall_num
from typing import List

class Solution:
    def getSubarrayBeauty(self, nums: List[int], k: int, x: int) -> List[int]:
        n = len(nums)
        result = []
        for i in range(n - k + 1):
            sub_array = sorted(nums[i:i+k])
            count = 0
            neg_count = 0
            for num in sub_array:
                if num < 0:
                    neg_count += 1
                    if neg_count == x:
                        result.append(num)
                        break
            else:
                result.append(0)
        return result
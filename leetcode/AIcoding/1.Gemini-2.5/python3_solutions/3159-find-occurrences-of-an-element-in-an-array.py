from typing import List

class Solution:
    def occurrencesOfElement(self, nums: List[int], queries: List[int], x: int) -> List[int]:
        x_indices = []
        for i in range(len(nums)):
            if nums[i] == x:
                x_indices.append(i)

        results = []
        for q in queries:
            if q <= len(x_indices):
                results.append(x_indices[q - 1])
            else:
                results.append(-1)

        return results
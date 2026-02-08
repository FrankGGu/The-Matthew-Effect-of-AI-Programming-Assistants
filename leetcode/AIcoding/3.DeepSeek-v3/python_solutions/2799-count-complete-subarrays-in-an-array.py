class Solution:
    def countCompleteSubarrays(self, nums: List[int]) -> int:
        distinct_elements = len(set(nums))
        count = 0
        n = len(nums)

        for i in range(n):
            current_elements = set()
            for j in range(i, n):
                current_elements.add(nums[j])
                if len(current_elements) == distinct_elements:
                    count += 1

        return count
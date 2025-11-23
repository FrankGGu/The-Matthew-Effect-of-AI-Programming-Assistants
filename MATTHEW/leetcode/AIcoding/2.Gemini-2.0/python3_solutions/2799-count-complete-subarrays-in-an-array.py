class Solution:
    def countCompleteSubarrays(self, nums: List[int]) -> int:
        distinct_elements = set(nums)
        k = len(distinct_elements)
        n = len(nums)
        count = 0
        for i in range(n):
            distinct_count = 0
            seen = set()
            for j in range(i, n):
                if nums[j] not in seen:
                    distinct_count += 1
                    seen.add(nums[j])
                if distinct_count == k:
                    count += 1
        return count
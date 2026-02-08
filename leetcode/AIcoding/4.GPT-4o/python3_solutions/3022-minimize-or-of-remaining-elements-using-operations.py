class Solution:
    def minimizeOR(self, nums: List[int], queries: List[int]) -> List[int]:
        results = []
        for q in queries:
            or_result = 0
            for num in nums:
                if num <= q:
                    or_result |= num
            results.append(or_result)
        return results
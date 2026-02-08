class Solution:
    def maximizeXor(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        nums.sort()
        result = []
        for x, m in queries:
            max_xor = -1
            for num in nums:
                if num <= m:
                    max_xor = max(max_xor, x ^ num)
                else:
                    break
            result.append(max_xor)
        return result
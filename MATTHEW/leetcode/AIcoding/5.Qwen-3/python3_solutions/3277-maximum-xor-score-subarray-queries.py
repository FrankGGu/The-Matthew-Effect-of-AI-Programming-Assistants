class Solution:
    def maxXORSubarrayQueries(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        from collections import defaultdict

        n = len(nums)
        prefix_xor = [0] * (n + 1)
        for i in range(n):
            prefix_xor[i + 1] = prefix_xor[i] ^ nums[i]

        result = []
        for l, r in queries:
            max_xor = 0
            for i in range(l, r + 1):
                current = prefix_xor[i + 1] ^ prefix_xor[l]
                if current > max_xor:
                    max_xor = current
            result.append(max_xor)

        return result
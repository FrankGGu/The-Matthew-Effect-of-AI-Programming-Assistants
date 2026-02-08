class Solution:
    def minimumXORSum(self, nums1: List[int], nums2: List[int]) -> int:
        n = len(nums1)
        dp = {}

        def solve(index, mask):
            if index == n:
                return 0

            if (index, mask) in dp:
                return dp[(index, mask)]

            min_xor_sum = float('inf')
            for i in range(n):
                if (mask >> i) & 1 == 0:
                    min_xor_sum = min(min_xor_sum, (nums1[index] ^ nums2[i]) + solve(index + 1, mask | (1 << i)))

            dp[(index, mask)] = min_xor_sum
            return min_xor_sum

        return solve(0, 0)
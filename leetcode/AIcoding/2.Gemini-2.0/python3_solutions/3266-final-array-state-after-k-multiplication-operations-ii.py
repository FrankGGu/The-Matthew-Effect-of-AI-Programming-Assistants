class Solution:
    def getFinalStateAfterKMultiplication(self, nums: list[int], queries: list[list[int]], k: int) -> list[int]:
        n = len(nums)
        ops = [0] * n
        for l, r, x in queries:
            ops[l] += x
            if r + 1 < n:
                ops[r + 1] -= x

        curr = 0
        for i in range(n):
            curr += ops[i]
            nums[i] *= pow(curr, k, 10**9 + 7)
            nums[i] %= (10**9 + 7)
        return nums
class Solution:
    def constructBitwiseArray(self, arr: list[int]) -> list[int]:
        n = len(arr)
        ans = [0] * n
        for i in range(n):
            ans[i] = arr[i]
            if i > 0:
                ans[i] |= ans[i-1]
        return ans
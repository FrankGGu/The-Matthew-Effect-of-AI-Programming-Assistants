class Solution:
    def findLengthOfShortestSubarray(self, arr: List[int]) -> int:
        n = len(arr)
        l, r = 0, n - 1
        while l < n - 1 and arr[l] <= arr[l + 1]:
            l += 1
        if l == n - 1:
            return 0
        while r > 0 and arr[r] >= arr[r - 1]:
            r -= 1
        ans = min(r, n - l - 1)
        i, j = 0, r
        while i <= l and j < n:
            if arr[i] <= arr[j]:
                ans = min(ans, j - i - 1)
                i += 1
            else:
                j += 1
        return ans
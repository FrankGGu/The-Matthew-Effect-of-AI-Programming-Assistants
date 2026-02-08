class Solution:
    def minOr(self, n: int, k: int) -> int:
        if n == k:
            return 0
        if k == 1:
            return (1 << (n - 1))

        low = 0
        high = 10**9
        ans = -1

        while low <= high:
            mid = (low + high) // 2

            count = 0
            temp = mid
            while temp > 0:
                count += temp & 1
                temp >>= 1

            if count <= n - k:
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans
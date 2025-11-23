import math

class Solution:
    def solve(self, nums, queries):
        n = len(nums)
        log_n = math.floor(math.log2(n)) + 1
        st = [[0] * n for _ in range(log_n)]

        for i in range(n):
            st[0][i] = nums[i]

        for j in range(1, log_n):
            for i in range(n - (1 << j) + 1):
                st[j][i] = math.gcd(st[j - 1][i], st[j - 1][i + (1 << (j - 1))])

        res = []
        for x, y in queries:
            l = x - 1
            r = y - 1
            length = r - l + 1
            k = math.floor(math.log2(length))
            current_gcd = math.gcd(st[k][l], st[k][r - (1 << k) + 1])
            res.append(current_gcd)
        return res
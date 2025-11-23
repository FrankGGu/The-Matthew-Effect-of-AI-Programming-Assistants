class Solution:
    def solve(self, n, guards):
        guards.sort()
        ans = 0
        if guards[0] > 1:
            ans += guards[0] - 1
        if guards[-1] < n:
            ans += n - guards[-1]

        for i in range(len(guards) - 1):
            if guards[i + 1] - guards[i] > 1:
                ans += (guards[i + 1] - guards[i] - 1) // 2
        return ans
class Solution:
    def punishmentNumber(self, n: int) -> int:
        def check(num):
            s = str(num * num)
            l = len(s)
            def dfs(i, total):
                if i == l:
                    return total == num
                for j in range(i, l):
                    val = int(s[i:j+1])
                    if dfs(j+1, total + val):
                        return True
                return False
            return dfs(0, 0)

        ans = 0
        for i in range(1, n + 1):
            if check(i):
                ans += i * i
        return ans
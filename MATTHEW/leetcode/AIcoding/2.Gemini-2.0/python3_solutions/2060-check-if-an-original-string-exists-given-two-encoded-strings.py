class Solution:
    def isOriginal(self, s1: str, s2: str) -> bool:
        m, n = len(s1), len(s2)
        dp = {}

        def solve(i, j, diff):
            if (i, j, diff) in dp:
                return dp[(i, j, diff)]

            if i == m and j == n:
                return diff == 0

            if i == m:
                if diff < 0:
                    return False
                num_str = ""
                for k in range(j, n):
                    num_str += s2[k]
                    if not num_str.isdigit():
                        break
                    num = int(num_str)
                    if 1 <= num <= 200 and diff - num == 0:
                        return True
                return False

            if j == n:
                if diff > 0:
                    return False
                num_str = ""
                for k in range(i, m):
                    num_str += s1[k]
                    if not num_str.isdigit():
                        break
                    num = int(num_str)
                    if 1 <= num <= 200 and diff + num == 0:
                        return True
                return False

            res = False
            if s1[i].isdigit() and s2[j].isdigit():
                num_str1 = ""
                for k in range(i, m):
                    num_str1 += s1[k]
                    if not num_str1.isdigit():
                        break
                    num1 = int(num_str1)
                    if 1 <= num1 <= 200:
                        num_str2 = ""
                        for l in range(j, n):
                            num_str2 += s2[l]
                            if not num_str2.isdigit():
                                break
                            num2 = int(num_str2)
                            if 1 <= num2 <= 200:
                                res |= solve(k + 1, l + 1, diff + num1 - num2)
                                if res:
                                    break
                        if res:
                            break
            elif s1[i].isdigit():
                num_str = ""
                for k in range(i, m):
                    num_str += s1[k]
                    if not num_str.isdigit():
                        break
                    num = int(num_str)
                    if 1 <= num <= 200:
                        res |= solve(k + 1, j + 1, diff + num - 1)
                        if res:
                            break
            elif s2[j].isdigit():
                num_str = ""
                for k in range(j, n):
                    num_str += s2[k]
                    if not num_str.isdigit():
                        break
                    num = int(num_str)
                    if 1 <= num <= 200:
                        res |= solve(i + 1, k + 1, diff - 1 + num)
                        if res:
                            break
            else:
                if s1[i] == s2[j]:
                    res = solve(i + 1, j + 1, diff)
                else:
                    res = False

            dp[(i, j, diff)] = res
            return res

        return solve(0, 0, 0)
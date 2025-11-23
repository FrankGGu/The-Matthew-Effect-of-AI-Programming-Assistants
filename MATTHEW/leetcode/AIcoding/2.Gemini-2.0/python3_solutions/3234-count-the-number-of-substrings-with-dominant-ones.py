def countSubstrings(s: str) -> int:
    n = len(s)
    ans = 0
    for i in range(n):
        ones = 0
        zeros = 0
        for j in range(i, n):
            if s[j] == '1':
                ones += 1
            else:
                zeros += 1
            if ones > zeros:
                ans += 1
    return ans
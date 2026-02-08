def solve():
    s = input()
    n = len(s)
    ans = 0
    for i in range(n):
        for j in range(i + 1, n + 1):
            sub = s[i:j]
            if len(set(sub)) == len(sub):
                ans += 1
    print(ans)

solve()
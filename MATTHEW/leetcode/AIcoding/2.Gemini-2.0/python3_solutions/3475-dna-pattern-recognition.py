def solve():
    s = input()
    n = len(s)
    ans = set()
    for i in range(n - 9):
        sub = s[i:i+10]
        if s.count(sub) > 1:
            ans.add(sub)
    print(list(ans))

solve()
def solve():
    s = input()
    n = len(s)
    ans = 0
    i = 0
    while i < n:
        num_str = ""
        while i < n and s[i].isdigit():
            num_str += s[i]
            i += 1
        if num_str:
            ans += int(num_str)
        else:
            i += 1
    print(ans)

solve()
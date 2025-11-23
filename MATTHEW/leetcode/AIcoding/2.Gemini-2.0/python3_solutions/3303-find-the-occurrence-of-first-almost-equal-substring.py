def solve():
    s = input()
    t = input()
    n = len(s)
    m = len(t)

    for i in range(n - m + 1):
        diff = 0
        for j in range(m):
            if s[i+j] != t[j]:
                diff += 1
        if diff <= 1:
            print(i)
            return
    print(-1)
def solve():
    n = int(input())
    a = list(map(int, input().split()))

    a.sort()

    ans = []
    l, r = 0, n - 1

    while l <= r:
        if l == r:
            ans.append(a[l])
            break
        ans.append(a[r])
        ans.append(a[l])
        l += 1
        r -= 1

    print(*ans)

solve()
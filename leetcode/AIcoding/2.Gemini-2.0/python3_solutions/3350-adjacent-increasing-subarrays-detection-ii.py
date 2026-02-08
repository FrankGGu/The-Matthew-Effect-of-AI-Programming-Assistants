def solve():
    n = int(input())
    a = list(map(int, input().split()))

    ans = 0
    i = 0
    while i < n - 1:
        if a[i] < a[i + 1]:
            j = i + 1
            while j < n - 1 and a[j] < a[j + 1]:
                j += 1
            ans += (j - i) * (j - i + 1) // 2
            i = j
        else:
            i += 1

    print(ans)

solve()
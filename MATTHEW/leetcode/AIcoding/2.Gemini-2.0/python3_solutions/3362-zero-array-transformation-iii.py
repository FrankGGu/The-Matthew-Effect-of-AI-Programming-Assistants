def solve():
    n = int(input())
    a = list(map(int, input().split()))

    def check(arr):
        return all(x == 0 for x in arr)

    if check(a):
        print("YES")
        return

    if a[0] == 0 and a[-1] == 0:
        print("NO")
        return

    if a[0] != 0 and a[-1] != 0:
        print("YES")
        return

    if a[0] == 0:
        first_nonzero = -1
        for i in range(n):
            if a[i] != 0:
                first_nonzero = i
                break

        if first_nonzero == -1:
            print("YES")
            return

        temp_arr = a[:]

        print("NO")
        return

    if a[-1] == 0:
        last_nonzero = -1
        for i in range(n-1,-1,-1):
            if a[i] != 0:
                last_nonzero = i
                break

        if last_nonzero == -1:
            print("YES")
            return

        print("NO")
        return

solve()
def solve():
    n = int(input())
    a = list(map(int, input().split()))

    ans = 0
    for i in range(n):
        for j in range(i, n):
            sub = a[i:j+1]

            if len(sub) % 2 == 0:
                continue

            mid = len(sub) // 2

            counts = {}
            for x in sub:
                counts[x] = counts.get(x, 0) + 1

            unique_mid = True

            mode_val = -1
            mode_count = -1

            for x in counts:
                if counts[x] > mode_count:
                    mode_count = counts[x]
                    mode_val = x

            if mode_val != sub[mid]:
                continue

            is_unique_mode = True
            num_modes = 0

            for x in counts:
              if counts[x] == mode_count:
                num_modes+=1

            if num_modes > 1:
              continue

            ans += 1

    print(ans)

solve()
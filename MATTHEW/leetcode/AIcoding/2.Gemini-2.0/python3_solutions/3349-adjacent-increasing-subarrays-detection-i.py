def solve():
    n = int(input())
    a = list(map(int, input().split()))

    count = 0
    i = 0
    while i < n - 1:
        if a[i+1] > a[i]:
            count += 1
            j = i + 1
            while j < n - 1 and a[j+1] > a[j]:
                j += 1
            i = j
        else:
            i += 1
    print(count)
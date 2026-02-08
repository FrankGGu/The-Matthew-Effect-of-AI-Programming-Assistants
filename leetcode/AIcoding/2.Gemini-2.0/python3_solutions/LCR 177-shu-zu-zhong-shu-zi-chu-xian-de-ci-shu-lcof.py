def solve():
    n = int(input())
    colors = list(map(int, input().split()))

    counts = {}
    for color in colors:
        counts[color] = counts.get(color, 0) + 1

    if len(counts) > 2:
        print(0)
        return

    if len(counts) == 1:
        print(n)
        return

    color1, color2 = counts.keys()
    count1 = counts[color1]
    count2 = counts[color2]

    if count1 == count2:
        print(n)
    else:
        print(2 * min(count1, count2))

solve()
def solve():
    n, k = map(int, input().split())
    heights = list(map(int, input().split()))

    max_altitude = float('-inf')
    for i in range(n - k + 1):
        current_altitude = sum(heights[i:i+k])
        max_altitude = max(max_altitude, current_altitude)

    print(max_altitude)

solve()
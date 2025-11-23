def solve():
    n, m = map(int, input().split())
    genes = []
    for _ in range(n):
        genes.append(input())

    def distance(s1, s2):
        count = 0
        for i in range(m):
            if s1[i] != s2[i]:
                count += 1
        return count

    min_dist = float('inf')
    for i in range(n):
        for j in range(i + 1, n):
            dist = distance(genes[i], genes[j])
            min_dist = min(min_dist, dist)

    print(min_dist)

solve()
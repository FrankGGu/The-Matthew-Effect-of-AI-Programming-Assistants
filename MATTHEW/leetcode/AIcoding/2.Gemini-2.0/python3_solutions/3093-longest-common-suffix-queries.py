def longestCommonSuffix(s1: str, s2: str) -> int:
    n1, n2 = len(s1), len(s2)
    i, j = n1 - 1, n2 - 1
    count = 0
    while i >= 0 and j >= 0 and s1[i] == s2[j]:
        count += 1
        i -= 1
        j -= 1
    return count

def solve():
    n, q = map(int, input().split())
    s = input()
    queries = []
    for _ in range(q):
        queries.append(list(map(int, input().split())))

    for l1, r1, l2, r2 in queries:
        sub1 = s[l1-1:r1]
        sub2 = s[l2-1:r2]
        print(longestCommonSuffix(sub1, sub2))
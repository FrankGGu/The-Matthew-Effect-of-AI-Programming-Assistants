def makeSubKSumEqual(arr: list[int], k: int) -> int:
    n = len(arr)
    k = gcd(n, k)
    ans = 0
    for i in range(k):
        sub_arr = []
        for j in range(i, n, k):
            sub_arr.append(arr[j])
        sub_arr.sort()
        median = sub_arr[len(sub_arr) // 2]
        for num in sub_arr:
            ans += abs(num - median)
    return ans

def gcd(a: int, b: int) -> int:
    if b == 0:
        return a
    return gcd(b, a % b)
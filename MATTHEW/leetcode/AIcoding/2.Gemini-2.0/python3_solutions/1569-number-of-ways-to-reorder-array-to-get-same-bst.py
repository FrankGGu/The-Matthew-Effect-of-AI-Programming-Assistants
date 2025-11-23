def numOfWays(nums: list[int]) -> int:
    MOD = 10**9 + 7
    n = len(nums)

    def combinations(n, k):
        if k < 0 or k > n:
            return 0
        if k == 0 or k == n:
            return 1
        if k > n // 2:
            k = n - k

        res = 1
        for i in range(k):
            res = (res * (n - i)) // (i + 1)
        return res

    def solve(arr):
        if len(arr) <= 1:
            return 1

        root = arr[0]
        left = [x for x in arr[1:] if x < root]
        right = [x for x in arr[1:] if x > root]

        return (combinations(len(left) + len(right), len(left)) * solve(left) * solve(right)) % MOD

    return (solve(nums) - 1) % MOD
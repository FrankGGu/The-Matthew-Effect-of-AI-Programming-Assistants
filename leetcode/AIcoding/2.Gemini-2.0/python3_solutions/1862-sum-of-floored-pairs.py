def sumOfFlooredPairs(nums: list[int]) -> int:
    MOD = 10**9 + 7
    count = [0] * 100001
    for num in nums:
        count[num] += 1

    for i in range(1, 100001):
        count[i] += count[i - 1]

    ans = 0
    seen = set()
    for num in nums:
        if num in seen:
            continue
        seen.add(num)

        for i in range(1, num + 1):
            l = i * num
            r = (i + 1) * num - 1

            r = min(r, 100000)

            if l <= r:
                c = count[r] - count[l - 1] if l > 0 else count[r]
                ans = (ans + c * i) % MOD

    return ans
class Solution:
    def threeSumMulti(self, arr: List[int], target: int) -> int:
        MOD = 10**9 + 7
        count = [0] * 101
        for num in arr:
            count[num] += 1

        res = 0

        for x in range(101):
            for y in range(x, 101):
                z = target - x - y
                if y <= z <= 100:
                    if x == y == z:
                        res += count[x] * (count[x] - 1) * (count[x] - 2) // 6
                    elif x == y:
                        res += count[x] * (count[x] - 1) // 2 * count[z]
                    elif y == z:
                        res += count[y] * (count[y] - 1) // 2 * count[x]
                    else:
                        res += count[x] * count[y] * count[z]

        return res % MOD
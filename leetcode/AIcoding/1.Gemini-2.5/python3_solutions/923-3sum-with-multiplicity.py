import collections

class Solution:
    def threeSumMulti(self, arr: list[int], target: int) -> int:
        counts = collections.Counter(arr)
        ans = 0
        MOD = 10**9 + 7

        for x in range(101):
            if counts[x] == 0:
                continue

            for y in range(x, 101):
                if counts[y] == 0:
                    continue

                z = target - x - y

                if z < y or z > 100:
                    continue

                if counts[z] == 0:
                    continue

                if x == y == z:
                    ans += counts[x] * (counts[x] - 1) * (counts[x] - 2) // 6
                elif x == y:
                    ans += counts[x] * (counts[x] - 1) // 2 * counts[z]
                elif y == z:
                    ans += counts[x] * counts[y] * (counts[y] - 1) // 2
                else: # x < y < z
                    ans += counts[x] * counts[y] * counts[z]

                ans %= MOD

        return ans
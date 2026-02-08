from collections import Counter

class Solution:
    def threeSumMulti(self, arr: list[int], target: int) -> int:
        count = Counter(arr)
        keys = sorted(count.keys())
        ans = 0
        MOD = 10**9 + 7

        for i in range(len(keys)):
            a = keys[i]
            for j in range(i, len(keys)):
                b = keys[j]
                c = target - a - b
                if c in count and c >= b:
                    if a == b == c:
                        ans += count[a] * (count[a] - 1) * (count[a] - 2) // 6
                    elif a == b != c:
                        ans += count[a] * (count[a] - 1) // 2 * count[c]
                    elif a != b == c:
                        ans += count[a] * count[b] * (count[b] - 1) // 2
                    elif a != b != c:
                        ans += count[a] * count[b] * count[c]
                    ans %= MOD
        return ans
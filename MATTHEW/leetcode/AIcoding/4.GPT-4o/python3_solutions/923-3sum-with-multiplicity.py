class Solution:
    def threeSumMulti(self, arr: List[int], target: int) -> int:
        from collections import Counter

        count = Counter(arr)
        keys = sorted(count.keys())
        result = 0

        for i in range(len(keys)):
            for j in range(i, len(keys)):
                k = target - keys[i] - keys[j]
                if k < keys[j]:
                    continue
                if k in count:
                    if i == j == keys.index(k):
                        result += count[keys[i]] * (count[keys[i]] - 1) * (count[keys[i]] - 2) // 6
                    elif i == j:
                        result += count[keys[i]] * (count[keys[i]] - 1) // 2 * count[k]
                    elif j == keys.index(k):
                        result += count[keys[j]] * count[keys[i]] * (count[keys[j]] - 1) // 2
                    else:
                        result += count[keys[i]] * count[keys[j]] * count[k]

        return result % (10**9 + 7)
class Solution:
    def maximumBeauty(self, flowers: List[int], newFlowers: int, target: int, full: int, partial: int) -> int:
        flowers = [min(f, target) for f in flowers]
        flowers.sort()
        n = len(flowers)
        if flowers[0] == target:
            return n * full

        cost = [0] * n
        for i in range(1, n):
            cost[i] = cost[i-1] + (flowers[i] - flowers[i-1]) * i

        res = 0
        j = n - 1
        while flowers[j] == target:
            j -= 1

        while newFlowers >= 0:
            while j >= 0 and cost[j] > newFlowers:
                j -= 1
            if j < 0:
                break
            min_val = flowers[j] + (newFlowers - cost[j]) // (j + 1) if j >= 0 else 0
            min_val = min(min_val, target - 1)
            total = (n - 1 - j) * full + min_val * partial
            res = max(res, total)

            if j == n - 1:
                break
            newFlowers -= (target - flowers[j + 1])
            flowers[j + 1] = target
            j += 1

        return res
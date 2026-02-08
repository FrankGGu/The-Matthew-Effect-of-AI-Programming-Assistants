class Solution:
    def countGoodMeals(self, deliciousness: List[int]) -> int:
        from collections import Counter
        count = Counter(deliciousness)
        mod = 10**9 + 7
        total = 0

        for x in count:
            for i in range(22):
                target = 2 ** i - x
                if target in count:
                    if target == x:
                        total += count[x] * (count[x] - 1) // 2
                    elif target > x:
                        total += count[x] * count[target]

        return total % mod
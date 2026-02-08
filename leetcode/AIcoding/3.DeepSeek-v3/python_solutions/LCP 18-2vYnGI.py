class Solution:
    def breakfastNumber(self, staple: List[int], drinks: List[int], x: int) -> int:
        staple.sort()
        drinks.sort()
        res = 0
        mod = 10**9 + 7
        m, n = len(staple), len(drinks)
        i, j = 0, n - 1
        while i < m and j >= 0:
            if staple[i] + drinks[j] <= x:
                res += j + 1
                i += 1
            else:
                j -= 1
        return res % mod
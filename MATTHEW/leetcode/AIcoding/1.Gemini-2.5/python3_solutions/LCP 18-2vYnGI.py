import bisect

class Solution:
    def breakfastCombinations(self, staple: list[int], drinks: list[int], x: int) -> int:
        staple.sort()
        drinks.sort()

        count = 0
        MOD = 10**9 + 7

        j = len(drinks) - 1
        for s_price in staple:
            while j >= 0 and s_price + drinks[j] > x:
                j -= 1

            if j < 0:
                break

            count = (count + j + 1) % MOD

        return count
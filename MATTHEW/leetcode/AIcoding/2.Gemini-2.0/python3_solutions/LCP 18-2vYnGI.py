class Solution:
    def breakfastNumber(self, staple: List[int], drinks: List[int], x: int) -> int:
        staple.sort()
        drinks.sort()
        count = 0
        j = len(drinks) - 1
        for i in range(len(staple)):
            while j >= 0 and staple[i] + drinks[j] > x:
                j -= 1
            if j >= 0:
                count += j + 1
            else:
                break
        return count % 1000000007
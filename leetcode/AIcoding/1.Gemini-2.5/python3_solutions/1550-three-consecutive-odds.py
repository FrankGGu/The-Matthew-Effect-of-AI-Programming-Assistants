class Solution:
    def threeConsecutiveOdds(self, arr: list[int]) -> bool:
        consecutive_odds = 0
        for num in arr:
            if num % 2 != 0:
                consecutive_odds += 1
                if consecutive_odds == 3:
                    return True
            else:
                consecutive_odds = 0
        return False
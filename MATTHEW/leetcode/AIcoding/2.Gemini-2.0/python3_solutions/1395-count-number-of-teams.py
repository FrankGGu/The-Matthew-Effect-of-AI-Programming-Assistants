class Solution:
    def numTeams(self, rating: List[int]) -> int:
        n = len(rating)
        count = 0
        for i in range(1, n - 1):
            less_left = 0
            greater_left = 0
            less_right = 0
            greater_right = 0
            for j in range(i):
                if rating[j] < rating[i]:
                    less_left += 1
                elif rating[j] > rating[i]:
                    greater_left += 1
            for j in range(i + 1, n):
                if rating[j] < rating[i]:
                    less_right += 1
                elif rating[j] > rating[i]:
                    greater_right += 1
            count += less_left * greater_right + greater_left * less_right
        return count
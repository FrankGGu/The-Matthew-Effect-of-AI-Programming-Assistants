class Solution:
    def findWinningPlayer(self, skills: List[int], k: int) -> int:
        n = len(skills)
        max_skill = max(skills)
        current_winner = 0
        current_streak = 0

        for i in range(1, n):
            if skills[current_winner] > skills[i]:
                current_streak += 1
            else:
                current_winner = i
                current_streak = 1

            if current_streak == k or skills[current_winner] == max_skill:
                return current_winner

        return current_winner
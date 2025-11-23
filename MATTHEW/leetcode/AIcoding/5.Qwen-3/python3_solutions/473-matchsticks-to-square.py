class Solution:
    def makesquare(self, matchsticks: List[int]) -> bool:
        total = sum(matchsticks)
        if total % 4 != 0:
            return False
        target = total // 4
        matchsticks.sort(reverse=True)
        if matchsticks[0] > target:
            return False

        used = [False] * len(matchsticks)

        def dfs(index, current, count):
            if count == 4:
                return True
            if current == target:
                return dfs(0, 0, count + 1)
            for i in range(index, len(matchsticks)):
                if not used[i] and current + matchsticks[i] <= target:
                    used[i] = True
                    if dfs(i + 1, current + matchsticks[i], count):
                        return True
                    used[i] = False
            return False

        return dfs(0, 0, 0)
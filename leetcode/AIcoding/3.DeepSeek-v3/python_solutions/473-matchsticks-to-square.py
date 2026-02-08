class Solution:
    def makesquare(self, matchsticks: List[int]) -> bool:
        if not matchsticks:
            return False

        perimeter = sum(matchsticks)
        if perimeter % 4 != 0:
            return False

        side = perimeter // 4
        matchsticks.sort(reverse=True)
        n = len(matchsticks)

        def backtrack(index, sides):
            if index == n:
                return all(s == side for s in sides)

            for i in range(4):
                if sides[i] + matchsticks[index] <= side:
                    sides[i] += matchsticks[index]
                    if backtrack(index + 1, sides):
                        return True
                    sides[i] -= matchsticks[index]
                    if sides[i] == 0:
                        break
            return False

        return backtrack(0, [0, 0, 0, 0])
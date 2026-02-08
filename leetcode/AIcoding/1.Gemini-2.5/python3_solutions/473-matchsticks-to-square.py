class Solution:
    def makesquare(self, matchsticks: list[int]) -> bool:
        total_sum = sum(matchsticks)

        if total_sum % 4 != 0:
            return False

        side_length = total_sum // 4

        matchsticks.sort(reverse=True)

        if matchsticks[0] > side_length:
            return False

        sides = [0] * 4

        def backtrack(index):
            if index == len(matchsticks):
                return True

            for i in range(4):
                if i > 0 and sides[i] == sides[i-1]:
                    continue

                if sides[i] + matchsticks[index] <= side_length:
                    sides[i] += matchsticks[index]

                    if backtrack(index + 1):
                        return True

                    sides[i] -= matchsticks[index]

            return False

        return backtrack(0)
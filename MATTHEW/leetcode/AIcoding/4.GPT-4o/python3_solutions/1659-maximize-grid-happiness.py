class Solution:
    def getMaxGridHappiness(self, m: int, n: int, maxStudents: int, introvertsCount: int, extrovertsCount: int) -> int:
        def dfs(i, j, students, introverts, extroverts, happiness):
            if students == maxStudents or i == m:
                return happiness if students == maxStudents else 0

            next_i, next_j = (i, j + 1) if j + 1 < n else (i + 1, 0)
            best_happiness = dfs(next_i, next_j, students, introverts, extroverts, happiness)

            if introverts > 0:
                new_happiness = happiness + 120
                if j > 0: new_happiness += 40
                if i > 0: new_happiness += 40
                best_happiness = max(best_happiness, dfs(next_i, next_j, students + 1, introverts - 1, extroverts, new_happiness))

            if extroverts > 0:
                new_happiness = happiness + 160
                if j > 0: new_happiness -= 20
                if i > 0: new_happiness -= 20
                if j < n - 1: new_happiness -= 20
                if i < m - 1: new_happiness -= 20
                best_happiness = max(best_happiness, dfs(next_i, next_j, students + 1, introverts, extroverts - 1, new_happiness))

            return best_happiness

        return dfs(0, 0, 0, introvertsCount, extrovertsCount, 0)
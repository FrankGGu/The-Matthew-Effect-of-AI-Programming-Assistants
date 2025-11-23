class Solution:
    def mostVisited(self, n: int, rounds: list[int]) -> list[int]:
        diff = [0] * (n + 2)

        for i in range(len(rounds) - 1):
            start = rounds[i]
            end = rounds[i+1]

            if start <= end:
                diff[start] += 1
                diff[end + 1] -= 1
            else:
                diff[start] += 1
                diff[n + 1] -= 1
                diff[1] += 1
                diff[end + 1] -= 1

        visits = [0] * (n + 1)
        current_count = 0
        for j in range(1, n + 1):
            current_count += diff[j]
            visits[j] = current_count

        max_visits = 0
        if n >= 1: # Constraint: n >= 2, so visits[1:] will always have elements
            max_visits = max(visits[1:])

        result = []
        for j in range(1, n + 1):
            if visits[j] == max_visits:
                result.append(j)

        return result
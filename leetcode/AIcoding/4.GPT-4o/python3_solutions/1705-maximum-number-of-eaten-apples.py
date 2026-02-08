class Solution:
    def eatenApples(self, apples: List[int], days: List[int]) -> int:
        max_days = max(i + d for i, d in zip(apples, days))
        eaten = 0
        available = []

        for day in range(1, max_days + 1):
            if day <= len(apples):
                available.append(apples[day - 1])

            if available:
                while available and available[0] <= 0:
                    available.pop(0)

                if available:
                    eaten += 1
                    available[0] -= 1

            if available:
                while available and available[0] <= 0:
                    available.pop(0)

            if day <= len(days):
                if len(available) < days[day - 1]:
                    available += [0] * (days[day - 1] - len(available))

        return eaten
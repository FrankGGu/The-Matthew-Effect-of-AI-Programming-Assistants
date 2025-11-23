class Solution:
    def sampleStats(self, count: List[int]) -> List[float]:
        total = sum(count)
        minimum = next(i for i, v in enumerate(count) if v > 0)
        maximum = next(i for i in range(255, -1, -1) if count[i] > 0)
        mean = sum(i * v for i, v in enumerate(count)) / total
        mode = max(range(256), key=lambda i: count[i])
        median = 0
        cumulative = 0

        for i in range(256):
            cumulative += count[i]
            if cumulative >= (total + 1) // 2:
                if total % 2 == 0 and cumulative - count[i] == (total // 2):
                    next_value = next(j for j in range(i + 1, 256) if count[j] > 0)
                    median = (i + next_value) / 2
                else:
                    median = i
                break

        return [minimum, maximum, mean, median, mode]
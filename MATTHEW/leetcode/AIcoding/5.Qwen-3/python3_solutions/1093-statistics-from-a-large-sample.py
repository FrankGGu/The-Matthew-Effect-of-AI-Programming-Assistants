class Solution:
    def sampleStats(self, count: List[int], balance: List[float]) -> List[float]:
        import math
        mean = 0.0
        median = 0.0
        mode = 0.0
        total = sum(count)
        max_count = 0
        for i in range(len(count)):
            if count[i] > max_count:
                max_count = count[i]
                mode = i
        cumulative = 0
        for i in range(len(count)):
            cumulative += count[i]
            if cumulative * 2 >= total:
                median = i
                break
        for i in range(len(count)):
            mean += i * balance[i]
        mean /= total
        return [mean, median, mode]
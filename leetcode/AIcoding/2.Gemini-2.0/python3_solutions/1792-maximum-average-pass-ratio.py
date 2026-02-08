import heapq

class Solution:
    def maxAverageRatio(self, classes: List[List[int]], extraStudents: int) -> float:
        pq = []
        for p, t in classes:
            pq.append([-((p + 1) / (t + 1) - p / t), p, t])
        heapq.heapify(pq)

        for _ in range(extraStudents):
            diff, p, t = heapq.heappop(pq)
            p += 1
            t += 1
            heapq.heappush(pq, [-((p + 1) / (t + 1) - p / t), p, t])

        total_ratio = 0
        for diff, p, t in pq:
            total_ratio += p / t

        return total_ratio / len(classes)
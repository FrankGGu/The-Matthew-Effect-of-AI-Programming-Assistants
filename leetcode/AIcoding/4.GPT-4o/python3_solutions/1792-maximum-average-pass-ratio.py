import heapq

class Solution:
    def maxAverageRatio(self, classes: List[List[int]], extraStudents: int) -> float:
        pq = []
        for pass_count, total_count in classes:
            heapq.heappush(pq, (-(pass_count + 1) / (total_count + 1) + pass_count / total_count, pass_count, total_count))

        for _ in range(extraStudents):
            diff, pass_count, total_count = heapq.heappop(pq)
            pass_count += 1
            total_count += 1
            heapq.heappush(pq, (-(pass_count + 1) / (total_count + 1) + pass_count / total_count, pass_count, total_count))

        total_avg = 0
        while pq:
            _, pass_count, total_count = heapq.heappop(pq)
            total_avg += pass_count / total_count

        return total_avg / len(classes)
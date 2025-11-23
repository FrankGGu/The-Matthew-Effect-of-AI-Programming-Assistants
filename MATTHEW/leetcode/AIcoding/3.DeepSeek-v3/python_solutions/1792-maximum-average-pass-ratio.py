import heapq

class Solution:
    def maxAverageRatio(self, classes: List[List[int]], extraStudents: int) -> float:
        heap = []
        for pass_num, total in classes:
            heapq.heappush(heap, (-((pass_num + 1) / (total + 1) - pass_num / total), pass_num, total))

        for _ in range(extraStudents):
            _, pass_num, total = heapq.heappop(heap)
            pass_num += 1
            total += 1
            heapq.heappush(heap, (-((pass_num + 1) / (total + 1) - pass_num / total), pass_num, total))

        total_ratio = 0.0
        for _, pass_num, total in heap:
            total_ratio += pass_num / total

        return total_ratio / len(classes)
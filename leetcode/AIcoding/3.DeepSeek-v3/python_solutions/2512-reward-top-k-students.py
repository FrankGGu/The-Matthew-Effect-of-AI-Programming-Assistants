import heapq

class Solution:
    def topStudents(self, positive_feedback: List[str], negative_feedback: List[str], report: List[str], student_id: List[int], k: int) -> List[int]:
        positive = set(positive_feedback)
        negative = set(negative_feedback)
        scores = []

        for i in range(len(report)):
            words = report[i].split()
            score = 0
            for word in words:
                if word in positive:
                    score += 3
                elif word in negative:
                    score -= 1
            scores.append((-score, student_id[i]))

        heapq.heapify(scores)
        result = []
        for _ in range(k):
            if scores:
                score, sid = heapq.heappop(scores)
                result.append(sid)

        return result
class Solution:
    def rewardStudents(self, positive_feedback: list[str], negative_feedback: list[str], report: list[str], student_id: list[int], k: int) -> list[int]:
        pos_set = set(positive_feedback)
        neg_set = set(negative_feedback)

        student_scores_data = []

        for i in range(len(report)):
            current_report = report[i]
            current_id = student_id[i]

            score = 0
            words = current_report.split()

            for word in words:
                if word in pos_set:
                    score += 3
                elif word in neg_set:
                    score -= 1

            student_scores_data.append((-score, current_id))

        student_scores_data.sort()

        result = []
        for i in range(k):
            result.append(student_scores_data[i][1])

        return result
class Solution:
    def findRelativeRanks(self, score: list[int]) -> list[str]:
        n = len(score)

        indexed_scores = []
        for i in range(n):
            indexed_scores.append((score[i], i))

        indexed_scores.sort(key=lambda x: x[0], reverse=True)

        answer = [""] * n

        for i in range(n):
            original_index = indexed_scores[i][1]

            if i == 0:
                answer[original_index] = "Gold Medal"
            elif i == 1:
                answer[original_index] = "Silver Medal"
            elif i == 2:
                answer[original_index] = "Bronze Medal"
            else:
                answer[original_index] = str(i + 1)

        return answer
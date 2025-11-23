class Solution:
    def bestRotation(self, A: List[int]) -> int:
        n = len(A)
        score = [0] * n

        for i in range(n):
            score[(i - A[i] + 1) % n] -= 1
            score[(i + 1) % n] += 1

        max_score, best_rotation = 0, 0
        current_score = 0

        for i in range(n):
            current_score += score[i]
            if current_score > max_score:
                max_score = current_score
                best_rotation = i

        return best_rotation
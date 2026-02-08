from typing import List

def maxPoints(arrows: int, aliceArrows: List[int]) -> List[int]:
    n = len(aliceArrows)
    result = [0] * n
    max_score = 0

    def dfs(index, remaining_arrows, current_score, current_result):
        nonlocal max_score, result
        if index == n or remaining_arrows <= 0:
            if current_score > max_score:
                max_score = current_score
                result = current_result[:]
            return

        # Skip current target
        dfs(index + 1, remaining_arrows, current_score, current_result)

        # Try to win against the current target
        if remaining_arrows > aliceArrows[index]:
            current_result[index] = aliceArrows[index] + 1
            dfs(index + 1, remaining_arrows - current_result[index], current_score + index, current_result)
            current_result[index] = 0

    dfs(0, arrows, 0, [0] * n)
    result[-1] += arrows - sum(result)
    return result
class Solution:
    def bagOfTokensScore(self, tokens: List[int], P: int) -> int:
        tokens.sort()
        score = 0
        max_score = 0
        left, right = 0, len(tokens) - 1

        while left <= right:
            if P >= tokens[left]:
                P -= tokens[left]
                score += 1
                max_score = max(max_score, score)
                left += 1
            elif score > 0:
                P += tokens[right]
                score -= 1
                right -= 1
            else:
                break

        return max_score
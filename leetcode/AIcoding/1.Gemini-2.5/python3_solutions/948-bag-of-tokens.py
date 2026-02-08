class Solution:
    def bagOfTokensScore(self, tokens: list[int], power: int) -> int:
        tokens.sort()

        left = 0
        right = len(tokens) - 1
        score = 0
        max_score = 0

        while left <= right:
            if power >= tokens[left]:
                # Play token face-up: gain 1 score, lose token power
                power -= tokens[left]
                score += 1
                left += 1
                max_score = max(max_score, score)
            elif score > 0 and left < right:
                # Play token face-down: lose 1 score, gain token power
                # Only do this if we have score to sacrifice and there are other tokens to potentially play
                power += tokens[right]
                score -= 1
                right -= 1
            else:
                # Cannot gain score and cannot gain power (or no score to sacrifice)
                break

        return max_score
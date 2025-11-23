class Solution:
    def bagOfTokens(self, tokens: List[int], power: int) -> int:
        tokens.sort()
        left = 0
        right = len(tokens) - 1
        max_bags = 0
        current_bags = 0

        while left <= right:
            if tokens[left] <= power:
                power -= tokens[left]
                left += 1
                current_bags += 1
            elif current_bags > 0:
                power += tokens[right]
                right -= 1
                current_bags -= 1
            else:
                break

        return max_bags
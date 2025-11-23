class Solution:
    def maxDepthAfterSplit(self, s: str) -> list[int]:
        answer = [0] * len(s)
        current_depth = 0
        for i, char in enumerate(s):
            if char == '(':
                answer[i] = current_depth % 2
                current_depth += 1
            else:  # char == ')'
                current_depth -= 1
                answer[i] = current_depth % 2
        return answer
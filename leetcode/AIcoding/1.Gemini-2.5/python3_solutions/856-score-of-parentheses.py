class Solution:
    def scoreOfParentheses(self, S: str) -> int:
        score = 0
        depth = 0
        for i in range(len(S)):
            if S[i] == '(':
                depth += 1
            else: # S[i] == ')'
                depth -= 1
                if S[i-1] == '(':
                    score += (1 << depth)
        return score
class Solution:
    def findMinNumber(self, S: str) -> str:
        n = len(S)
        result = []
        stack = []
        for i in range(n + 1):
            stack.append(i + 1)
            if i == n or S[i] == 'I':
                while stack:
                    result.append(str(stack.pop()))
        return ''.join(result)
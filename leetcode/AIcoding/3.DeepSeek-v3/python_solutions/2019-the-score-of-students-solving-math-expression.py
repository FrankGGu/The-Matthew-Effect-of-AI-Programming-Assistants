class Solution:
    def scoreOfStudents(self, s: str, answers: List[int]) -> int:
        n = len(s)
        correct = self.computeCorrect(s)
        dp = [[set() for _ in range(n)] for __ in range(n)]

        for i in range(0, n, 2):
            dp[i][i].add(int(s[i]))

        for length in range(3, n + 1, 2):
            for i in range(0, n - length + 1, 2):
                j = i + length - 1
                for k in range(i + 1, j, 2):
                    left = dp[i][k - 1]
                    right = dp[k + 1][j]
                    op = s[k]
                    for a in left:
                        for b in right:
                            if op == '+':
                                val = a + b
                            else:
                                val = a * b
                            if val <= 1000:
                                dp[i][j].add(val)

        possible = dp[0][n - 1]
        res = 0
        for ans in answers:
            if ans == correct:
                res += 5
            elif ans in possible:
                res += 2
        return res

    def computeCorrect(self, s: str) -> int:
        stack = []
        num = 0
        op = '+'
        for c in s + '+':
            if c.isdigit():
                num = num * 10 + int(c)
            else:
                if op == '+':
                    stack.append(num)
                elif op == '*':
                    stack.append(stack.pop() * num)
                op = c
                num = 0
        return sum(stack)
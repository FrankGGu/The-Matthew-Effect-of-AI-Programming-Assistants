class Solution:
    def scoreOfStudents(self, s: str, answers: List[int]) -> int:
        def calculate(expr):
            return eval(expr)

        def dfs(expr):
            if expr.isdigit():
                return {int(expr)}
            results = set()
            for i in range(len(expr)):
                if expr[i] in "+*":
                    left = dfs(expr[:i])
                    right = dfs(expr[i + 1:])
                    for l in left:
                        for r in right:
                            if expr[i] == '+':
                                results.add(l + r)
                            else:
                                results.add(l * r)
        actual = calculate(s)
        possible_scores = dfs(s)
        correct = answers.count(actual)
        wrong = sum(1 for ans in answers if ans in possible_scores and ans != actual)
        return 5 * correct + 2 * wrong
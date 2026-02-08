class Solution:
    def scoreOfStudents(self, s: str, answers: List[int]) -> int:
        def calculate(expr):
            nums = []
            ops = []
            i = 0
            while i < len(expr):
                if expr[i].isdigit():
                    num = 0
                    while i < len(expr) and expr[i].isdigit():
                        num = num * 10 + int(expr[i])
                        i += 1
                    nums.append(num)
                    i -= 1
                elif expr[i] == '+':
                    ops.append('+')
                elif expr[i] == '*':
                    ops.append('*')
                i += 1

            while '*' in ops:
                idx = ops.index('*')
                nums[idx] = nums[idx] * nums[idx + 1]
                nums.pop(idx + 1)
                ops.pop(idx)

            res = nums[0]
            for i in range(len(ops)):
                if ops[i] == '+':
                    res += nums[i + 1]
            return res

        correct_answer = calculate(s.split())
        valid_answers = set()

        def calculate_dp(start, end):
            if start == end:
                return {int(s_list[start])}

            key = (start, end)
            if key in memo:
                return memo[key]

            results = set()
            for i in range(start, end):
                if s_list[i] == '+' or s_list[i] == '*':
                    left_results = calculate_dp(start, i - 1)
                    right_results = calculate_dp(i + 1, end)

                    for left in left_results:
                        for right in right_results:
                            if s_list[i] == '+':
                                res = left + right
                            else:
                                res = left * right

                            if 0 <= res <= 1000:
                                results.add(res)
            memo[key] = results
            return results

        s_list = s.split()
        memo = {}
        valid_answers = calculate_dp(0, len(s_list) - 1)

        score = 0
        counts = {}
        for ans in answers:
            if ans == correct_answer:
                score += 5
            elif ans in valid_answers:
                score += 2

        return score
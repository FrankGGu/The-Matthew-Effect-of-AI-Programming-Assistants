class Solution:
    def scoreOfStudents(self, s: str, answers: List[int]) -> int:
        n = len(s)
        nums = []
        ops = []
        for i in range(n):
            if s[i].isdigit():
                nums.append(int(s[i]))
            else:
                ops.append(s[i])

        def calculate(nums, ops):
            res = nums[0]
            for i in range(len(ops)):
                if ops[i] == '+':
                    res += nums[i + 1]
                elif ops[i] == '*':
                    res *= nums[i + 1]
            return res

        correct_answer = calculate(nums, ops)

        dp = {}

        def calculate_range(start, end):
            if (start, end) in dp:
                return dp[(start, end)]

            if start == end:
                dp[(start, end)] = {nums[start]}
                return dp[(start, end)]

            res = set()
            for i in range(start, end):
                if ops[i] == '+':
                    left = calculate_range(start, i)
                    right = calculate_range(i + 1, end)
                    for l in left:
                        for r in right:
                            if l + r <= 1000:
                                res.add(l + r)
                elif ops[i] == '*':
                    left = calculate_range(start, i)
                    right = calculate_range(i + 1, end)
                    for l in left:
                        for r in right:
                            if l * r <= 1000:
                                res.add(l * r)

            dp[(start, end)] = res
            return dp[(start, end)]

        possible_answers = calculate_range(0, len(nums) - 1)

        score = 0
        for answer in answers:
            if answer == correct_answer:
                score += 5
            elif answer in possible_answers:
                score += 2

        return score
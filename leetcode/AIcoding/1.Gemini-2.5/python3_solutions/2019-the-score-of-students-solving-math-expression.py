class Solution:
    def calculateScore(self, s: str, student_answers: list[int]) -> int:
        # Parse the expression into numbers and operators
        numbers = []
        operators = []
        current_num_str = ""
        for char in s:
            if char.isdigit():
                current_num_str += char
            else:
                numbers.append(int(current_num_str))
                current_num_str = ""
                operators.append(char)
        numbers.append(int(current_num_str))

        n = len(numbers)

        # Step 1: Find all possible results a student could get
        # dp[i][j] stores a set of all possible results for the subexpression numbers[i]...numbers[j]
        # where i is the start index of numbers and j is the end index of numbers.
        # The operators involved are operators[i]...operators[j-1].
        dp = [[set() for _ in range(n)] for _ in range(n)]

        # Base case: a single number has only one result
        for i in range(n):
            dp[i][i].add(numbers[i])

        # Fill the DP table for increasing lengths of subexpressions
        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                for k in range(i, j): # k is the split point. The operator at operators[k] combines dp[i][k] and dp[k+1][j].
                    op = operators[k]
                    for val1 in dp[i][k]:
                        for val2 in dp[k+1][j]:
                            res = 0
                            if op == '+':
                                res = val1 + val2
                            else: # op == '*'
                                res = val1 * val2

                            # Filter results greater than 1000
                            if res <= 1000:
                                dp[i][j].add(res)

        all_possible_results = dp[0][n-1]

        # Step 2: Calculate the correct answer using standard operator precedence
        # First, handle multiplications
        # This uses a temporary list to store numbers after multiplication, and then sums them up.

        # current_val accumulates numbers joined by '*'
        # temp_nums stores values separated by '+'
        temp_nums = []
        current_val = numbers[0]
        for i in range(len(operators)):
            if operators[i] == '*':
                current_val *= numbers[i+1]
            else: # operators[i] == '+'
                temp_nums.append(current_val)
                current_val = numbers[i+1] # Start accumulating for the next segment
        temp_nums.append(current_val) # Add the last accumulated value

        # Then, handle additions
        correct_answer = 0
        for val in temp_nums:
            correct_answer += val

        # Step 3: Score the student answers
        total_score = 0
        for student_ans in student_answers:
            if student_ans == correct_answer:
                total_score += 5
            elif student_ans in all_possible_results:
                total_score += 2

        return total_score
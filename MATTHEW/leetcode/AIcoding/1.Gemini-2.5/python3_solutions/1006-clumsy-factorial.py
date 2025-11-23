class Solution:
    def clumsy(self, n: int) -> int:
        if n == 1:
            return 1
        if n == 2:
            return 2
        if n == 3:
            return 6

        stack = [n]
        op_idx = 0 # 0:*, 1:/, 2:+, 3:-

        for i in range(n - 1, 0, -1):
            op_type = op_idx % 4

            if op_type == 0: # Multiplication
                stack.append(stack.pop() * i)
            elif op_type == 1: # Division
                stack.append(int(stack.pop() / i))
            elif op_type == 2: # Addition
                stack.append(i)
            else: # op_type == 3, Subtraction
                stack.append(-i)

            op_idx += 1

        return sum(stack)
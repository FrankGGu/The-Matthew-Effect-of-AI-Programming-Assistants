class Solution:
    def clumsy(self, N: int) -> int:
        if N == 0:
            return 0
        if N == 1:
            return 1
        if N == 2:
            return 2
        if N == 3:
            return 6

        stack = []
        sign = 1

        for i in range(N, 0, -1):
            if i == N:
                stack.append(i)
            elif (N - i) % 4 == 1:
                stack.append(stack.pop() * i)
            elif (N - i) % 4 == 2:
                stack.append(stack.pop() // i)
            elif (N - i) % 4 == 3:
                stack.append(i)
            else:
                stack.append(-i)

        return sum(stack)
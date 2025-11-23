class Solution:
    def dailyTemperatures(self, T: List[int]) -> List[int]:
        n = len(T)
        result = [0] * n
        stack = []

        for i in range(n):
            while stack and T[i] > T[stack[-1]]:
                index = stack.pop()
                result[index] = i - index
            stack.append(i)

        return result
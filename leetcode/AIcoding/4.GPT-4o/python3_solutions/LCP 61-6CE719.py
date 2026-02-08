class Solution:
    def dailyTemperatures(self, T: List[int]) -> List[int]:
        n = len(T)
        answer = [0] * n
        stack = []

        for i in range(n):
            while stack and T[i] > T[stack[-1]]:
                idx = stack.pop()
                answer[idx] = i - idx
            stack.append(i)

        return answer
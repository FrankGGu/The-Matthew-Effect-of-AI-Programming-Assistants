class Solution:
    def getCollisionTime(self, position: List[int], speed: List[int]) -> List[float]:
        n = len(position)
        stack = []
        result = [-1] * n

        for i in sorted(range(n), key=lambda i: position[i]):
            while stack:
                j = stack[-1]
                if speed[i] <= speed[j]:
                    break
                time = (position[j] - position[i]) / (speed[i] - speed[j])
                if result[j] == -1 or time < result[j]:
                    result[j] = time
                stack.pop()
            stack.append(i)

        return result
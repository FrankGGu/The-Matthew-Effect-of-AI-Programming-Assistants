class Solution:
    def canReach(self, arr: List[int], start: int) -> bool:
        n = len(arr)
        visited = [False] * n
        stack = [start]

        while stack:
            index = stack.pop()
            if arr[index] == 0:
                return True
            if visited[index]:
                continue
            visited[index] = True

            jump = arr[index]
            if index + jump < n:
                stack.append(index + jump)
            if index - jump >= 0:
                stack.append(index - jump)

        return False
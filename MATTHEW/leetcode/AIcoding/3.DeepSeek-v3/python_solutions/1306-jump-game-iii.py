class Solution:
    def canReach(self, arr: List[int], start: int) -> bool:
        n = len(arr)
        visited = [False] * n
        queue = deque()
        queue.append(start)
        visited[start] = True

        while queue:
            current = queue.popleft()
            if arr[current] == 0:
                return True
            left = current - arr[current]
            if left >= 0 and not visited[left]:
                visited[left] = True
                queue.append(left)
            right = current + arr[current]
            if right < n and not visited[right]:
                visited[right] = True
                queue.append(right)

        return False
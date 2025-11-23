class Solution:
    def canReach(self, arr: List[int], start: int) -> bool:
        n = len(arr)
        visited = set()

        def dfs(index):
            if index < 0 or index >= n or index in visited:
                return False
            visited.add(index)
            if arr[index] == 0:
                return True
            return dfs(index + arr[index]) or dfs(index - arr[index])

        return dfs(start)
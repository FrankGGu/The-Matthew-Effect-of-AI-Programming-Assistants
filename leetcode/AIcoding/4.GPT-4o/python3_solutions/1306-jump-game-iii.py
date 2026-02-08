class Solution:
    def canReach(self, arr: List[int], start: int) -> bool:
        n = len(arr)
        visited = set()
        stack = [start]

        while stack:
            index = stack.pop()
            if index < 0 or index >= n or index in visited:
                continue
            if arr[index] == 0:
                return True
            visited.add(index)
            stack.append(index + arr[index])
            stack.append(index - arr[index])

        return False
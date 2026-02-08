class Solution:
    def countArrangement(self, n: int) -> int:
        count = 0
        visited = [False] * (n + 1)

        def backtrack(current_index):
            nonlocal count
            if current_index > n:
                count += 1
                return

            for num in range(1, n + 1):
                if not visited[num]:
                    if num % current_index == 0 or current_index % num == 0:
                        visited[num] = True
                        backtrack(current_index + 1)
                        visited[num] = False

        backtrack(1)
        return count
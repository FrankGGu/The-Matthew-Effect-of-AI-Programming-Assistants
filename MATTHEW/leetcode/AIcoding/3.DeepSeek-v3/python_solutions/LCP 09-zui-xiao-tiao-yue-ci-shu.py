class Solution:
    def minJump(self, jump: List[int]) -> int:
        n = len(jump)
        max_reach = 0
        steps = 0
        end = 0
        queue = []
        queue.append(0)
        visited = [False] * n
        visited[0] = True

        while queue:
            size = len(queue)
            for _ in range(size):
                pos = queue.pop(0)
                if pos + jump[pos] >= n:
                    return steps + 1
                if not visited[pos + jump[pos]]:
                    visited[pos + jump[pos]] = True
                    queue.append(pos + jump[pos])
                for i in range(max_reach + 1, pos):
                    if not visited[i]:
                        visited[i] = True
                        queue.append(i)
                max_reach = max(max_reach, pos)
            steps += 1
        return -1
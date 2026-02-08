class Solution:
    def isEscapePossible(self, blocked: list[list[int]], source: list[int], target: list[int]) -> bool:
        blocked_set = set(tuple(block) for block in blocked)

        def bfs(start, end):
            visited = set()
            q = [start]
            visited.add(tuple(start))
            count = 0

            while q:
                curr = q.pop(0)
                count += 1
                if curr == end:
                    return True

                if count > 20000:
                    return True

                neighbors = [(curr[0] + 1, curr[1]), (curr[0] - 1, curr[1]), (curr[0], curr[1] + 1), (curr[0], curr[1] - 1)]

                for neighbor in neighbors:
                    if 0 <= neighbor[0] < 10**6 and 0 <= neighbor[1] < 10**6 and tuple(neighbor) not in blocked_set and tuple(neighbor) not in visited:
                        q.append(neighbor)
                        visited.add(tuple(neighbor))

            return False

        return bfs(source, target) and bfs(target, source)
class Solution:
    def findAllPeople(self, n: int, meetings: List[List[int]], firstPerson: int) -> List[int]:
        from collections import defaultdict, deque

        meetings.append([0, firstPerson, 0])
        graph = defaultdict(list)

        for x, y, time in meetings:
            graph[time].append((x, y))

        def bfs(start, end_time):
            queue = deque([start])
            visited = {start}
            while queue:
                person = queue.popleft()
                for neighbor in graph[end_time]:
                    if person in neighbor:
                        other = neighbor[0] if neighbor[1] == person else neighbor[1]
                        if other not in visited:
                            visited.add(other)
                            queue.append(other)
            return visited

        times = sorted(graph.keys())
        result = {0, firstPerson}

        for i in range(len(times) - 1):
            curr_time = times[i]
            next_time = times[i + 1]
            if next_time - curr_time > 0:
                visited = bfs(0, curr_time)
                result = result.intersection(visited)

        return sorted(result)
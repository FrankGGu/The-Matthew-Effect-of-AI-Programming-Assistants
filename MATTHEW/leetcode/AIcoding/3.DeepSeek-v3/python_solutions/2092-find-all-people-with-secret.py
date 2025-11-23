class Solution:
    def findAllPeople(self, n: int, meetings: List[List[int]], firstPerson: int) -> List[int]:
        known = {0, firstPerson}
        meetings.sort(key=lambda x: x[2])

        i = 0
        while i < len(meetings):
            time = meetings[i][2]
            graph = defaultdict(list)
            current_meetings = []

            while i < len(meetings) and meetings[i][2] == time:
                x, y, _ = meetings[i]
                graph[x].append(y)
                graph[y].append(x)
                current_meetings.append((x, y))
                i += 1

            queue = deque()
            for person in graph:
                if person in known:
                    queue.append(person)

            while queue:
                current = queue.popleft()
                for neighbor in graph[current]:
                    if neighbor not in known:
                        known.add(neighbor)
                        queue.append(neighbor)

        return sorted(known)
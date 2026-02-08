import collections

class Solution:
    def canVisitAllRooms(self, rooms: list[list[int]]) -> bool:
        n = len(rooms)
        visited = set()
        queue = collections.deque()

        queue.append(0)
        visited.add(0)

        while queue:
            current_room = queue.popleft()

            for key in rooms[current_room]:
                if key not in visited:
                    visited.add(key)
                    queue.append(key)

        return len(visited) == n
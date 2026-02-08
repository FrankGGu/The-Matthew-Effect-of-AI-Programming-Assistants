class Solution:
    def canVisitAllRooms(self, rooms: list[list[int]]) -> bool:
        n = len(rooms)
        visited = [False] * n
        visited[0] = True
        queue = [0]

        while queue:
            room_index = queue.pop(0)
            for key in rooms[room_index]:
                if not visited[key]:
                    visited[key] = True
                    queue.append(key)

        return all(visited)
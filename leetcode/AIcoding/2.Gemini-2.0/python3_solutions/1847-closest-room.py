class Solution:
    def closestRoom(self, rooms: List[List[int]], queries: List[List[int]]) -> List[int]:
        rooms.sort()
        n = len(queries)
        res = [-1] * n
        for i, (prefSize, minSize) in enumerate(queries):
            queries[i].append(i)
        queries.sort(key=lambda x: x[1])

        valid_rooms = []
        room_idx = len(rooms) - 1

        while room_idx >= 0 and rooms[room_idx][1] >= queries[-1][1]:
            valid_rooms.append(rooms[room_idx][0])
            room_idx -= 1

        valid_rooms.sort()

        for prefSize, minSize, idx in reversed(queries):
            while room_idx >= 0 and rooms[room_idx][1] >= minSize:
                valid_rooms.append(rooms[room_idx][0])
                room_idx -= 1
                valid_rooms.sort()

            if not valid_rooms:
                continue

            l, r = 0, len(valid_rooms) - 1
            closest_room = -1
            min_diff = float('inf')

            while l <= r:
                mid = (l + r) // 2
                diff = abs(valid_rooms[mid] - prefSize)
                if diff < min_diff:
                    min_diff = diff
                    closest_room = valid_rooms[mid]
                elif diff == min_diff:
                    closest_room = min(closest_room, valid_rooms[mid])

                if valid_rooms[mid] < prefSize:
                    l = mid + 1
                else:
                    r = mid - 1

            res[idx] = closest_room

        return res
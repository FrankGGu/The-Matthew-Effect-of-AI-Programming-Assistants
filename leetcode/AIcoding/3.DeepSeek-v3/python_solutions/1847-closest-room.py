import bisect

class Solution:
    def closestRoom(self, rooms: List[List[int]], queries: List[List[int]]) -> List[int]:
        rooms.sort(key=lambda x: x[1])
        sorted_sizes = [size for _, size in rooms]
        room_ids = [id for id, _ in rooms]
        n = len(rooms)

        res = []
        for preferred, minSize in queries:
            idx = bisect.bisect_left(sorted_sizes, minSize)
            candidates = room_ids[idx:]
            if not candidates:
                res.append(-1)
                continue
            left = 0
            right = len(candidates) - 1
            closest = None
            min_diff = float('inf')
            while left <= right:
                mid = (left + right) // 2
                current_id = candidates[mid]
                current_diff = abs(current_id - preferred)
                if current_diff < min_diff or (current_diff == min_diff and current_id < closest):
                    min_diff = current_diff
                    closest = current_id
                if current_id < preferred:
                    left = mid + 1
                else:
                    right = mid - 1
            res.append(closest)
        return res
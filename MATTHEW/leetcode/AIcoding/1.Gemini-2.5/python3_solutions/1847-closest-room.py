from sortedcontainers import SortedList

class Solution:
    def closestRoom(self, rooms: list[list[int]], queries: list[list[int]]) -> list[int]:
        # 1. Augment queries with their original index and sort them by minSize in descending order.
        # This allows us to process queries from largest minSize to smallest.
        # As minSize decreases, more rooms become eligible.
        queries_indexed = []
        for i, (preferred_id, min_size) in enumerate(queries):
            queries_indexed.append((min_size, preferred_id, i))

        queries_indexed.sort(key=lambda x: x[0], reverse=True)

        # 2. Sort rooms by size in descending order.
        # This helps us efficiently add eligible rooms to our data structure
        # as we iterate through the sorted queries.
        rooms.sort(key=lambda x: x[1], reverse=True)

        ans = [-1] * len(queries)

        # room_ids_available will store room IDs of rooms that satisfy the current min_size requirement.
        # SortedList provides efficient insertion, deletion, and finding elements near a value (using bisect).
        room_ids_available = SortedList()

        room_ptr = 0 # Pointer for iterating through the sorted rooms array

        # 3. Process queries
        for min_size, preferred_id, original_index in queries_indexed:
            # Add rooms that meet the current min_size requirement to room_ids_available.
            # Since both rooms and queries are sorted by size/min_size descending,
            # we only need to iterate through rooms once.
            while room_ptr < len(rooms) and rooms[room_ptr][1] >= min_size:
                room_ids_available.add(rooms[room_ptr][0]) # Add roomId
                room_ptr += 1

            # If no rooms are available for the current min_size, the answer for this query is -1.
            if not room_ids_available:
                continue

            # Find the closest room ID in room_ids_available to preferred_id.

            # bisect_left returns an insertion point (index) which maintains sorted order.
            # It's the index where preferred_id would be inserted, meaning:
            # - All elements to the left of idx are <= preferred_id.
            # - All elements at or to the right of idx are >= preferred_id.
            idx = room_ids_available.bisect_left(preferred_id)

            closest_room_id = -1
            min_diff = float('inf')

            # Candidate 1: The room ID at or to the right of preferred_id (if it exists).
            if idx < len(room_ids_available):
                candidate1_id = room_ids_available[idx]
                diff1 = abs(candidate1_id - preferred_id)
                closest_room_id = candidate1_id
                min_diff = diff1

            # Candidate 2: The room ID to the left of preferred_id (if it exists).
            if idx > 0:
                candidate2_id = room_ids_available[idx - 1]
                diff2 = abs(candidate2_id - preferred_id)

                if diff2 < min_diff:
                    closest_room_id = candidate2_id
                    min_diff = diff2
                elif diff2 == min_diff:
                    # Tie-breaking rule: If differences are equal, choose the room with the smaller ID.
                    # Since candidate2_id is always smaller than candidate1_id,
                    # we take the minimum of the current closest_room_id and candidate2_id.
                    closest_room_id = min(closest_room_id, candidate2_id)

            ans[original_index] = closest_room_id

        return ans
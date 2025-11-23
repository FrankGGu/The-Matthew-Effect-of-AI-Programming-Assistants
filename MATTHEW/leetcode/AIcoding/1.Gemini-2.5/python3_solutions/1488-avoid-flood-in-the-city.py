import collections
import heapq

class Solution:
    def avoidFlood(self, rains: list[int]) -> list[int]:
        n = len(rains)
        ans = [-1] * n

        # Precompute all rain days for each lake
        # lake_id -> deque of indices where it rains
        # Using deque for efficient popleft
        next_rain_map = collections.defaultdict(collections.deque)
        for i, lake_id in enumerate(rains):
            if lake_id > 0:
                next_rain_map[lake_id].append(i)

        # Stores lakes that are currently full.
        # lake_id -> True (acts as a set of currently full lakes)
        full_lakes = {}

        # Min-heap to store (next_rain_day_index, lake_id) for lakes that are currently full
        # and will rain again. This helps in choosing which lake to dry on a dry day:
        # we prioritize drying the lake that will rain again soonest.
        lakes_to_dry_soon = [] # (next_rain_day_index, lake_id)

        for i in range(n):
            lake_id = rains[i]

            if lake_id > 0:  # It rains on lake_id
                ans[i] = 0  # Mark this day as a rain day (ans[i] = 0 for rain days)

                # Remove the current rain day from its lake's queue of future rain days
                next_rain_map[lake_id].popleft()

                if lake_id in full_lakes:
                    # Lake is already full, and it rains again -> Flood!
                    return []

                # Mark the lake as full
                full_lakes[lake_id] = True

                # If this lake will rain again in the future, add it to the min-heap
                # so we know to prioritize drying it before its next rain
                if next_rain_map[lake_id]:
                    next_rain_day_for_this_lake = next_rain_map[lake_id][0]
                    heapq.heappush(lakes_to_dry_soon, (next_rain_day_for_this_lake, lake_id))

            else:  # rains[i] == 0, it's a dry day
                if not lakes_to_dry_soon:
                    # No lakes are currently full and will rain again.
                    # We can dry any lake, so we default to lake 1 as per problem description.
                    ans[i] = 1
                else:
                    # Pick the lake that will rain soonest from the heap
                    next_rain_day, lake_to_dry = heapq.heappop(lakes_to_dry_soon)

                    # If the next rain day for this lake is today or in the past,
                    # it means we've already missed the chance to dry it and a flood occurred.
                    # (This check should ideally not be triggered if logic for adding to heap is perfect,
                    # as next_rain_day should always be > i).
                    if next_rain_day <= i:
                         return []

                    ans[i] = lake_to_dry
                    # Mark the lake as no longer full since it was dried
                    del full_lakes[lake_to_dry]

        return ans
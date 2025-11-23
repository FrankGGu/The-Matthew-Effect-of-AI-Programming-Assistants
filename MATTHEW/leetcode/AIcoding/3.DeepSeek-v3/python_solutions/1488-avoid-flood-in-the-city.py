class Solution:
    def avoidFlood(self, rains: List[int]) -> List[int]:
        from collections import defaultdict
        import bisect

        lake_to_days = defaultdict(list)
        for day, lake in enumerate(rains):
            if lake != 0:
                lake_to_days[lake].append(day)

        next_rain = {}
        res = []
        dry_days = []

        for day, lake in enumerate(rains):
            if lake != 0:
                res.append(-1)
                if lake in next_rain:
                    return []
                next_rain[lake] = lake_to_days[lake].pop(0) if lake_to_days[lake] else float('inf')
            else:
                res.append(1)
                dry_days.append(day)

        for day, lake in enumerate(rains):
            if lake != 0:
                if lake in next_rain and next_rain[lake] < day:
                    idx = bisect.bisect_left(dry_days, next_rain[lake])
                    if idx >= len(dry_days) or dry_days[idx] >= day:
                        return []
                    res[dry_days.pop(idx)] = lake
                    next_rain[lake] = lake_to_days[lake].pop(0) if lake_to_days[lake] else float('inf')

        return res
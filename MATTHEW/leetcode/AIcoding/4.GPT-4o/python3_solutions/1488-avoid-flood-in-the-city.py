class Solution:
    def avoidFlood(self, rains: List[int]) -> List[int]:
        n = len(rains)
        water = {}
        result = [-1] * n
        dry_days = []

        for i in range(n):
            if rains[i] > 0:
                if rains[i] in water:
                    return []
                water[rains[i]] = i
                result[i] = -1
            else:
                dry_days.append(i)
                result[i] = 1

        for i in range(n):
            if rains[i] > 0:
                if rains[i] in water:
                    idx = water[rains[i]]
                    if idx != i:
                        while dry_days and dry_days[0] < idx:
                            dry_days.pop(0)
                        if dry_days:
                            result[dry_days.pop(0)] = rains[i]
                    water[rains[i]] = i

        return result
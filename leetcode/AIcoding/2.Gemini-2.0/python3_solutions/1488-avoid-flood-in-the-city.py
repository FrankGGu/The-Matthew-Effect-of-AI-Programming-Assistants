class Solution:
    def avoidFlood(self, rains: list[int]) -> list[int]:
        n = len(rains)
        ans = [1] * n
        full_lakes = {}
        dry_days = []

        for i in range(n):
            if rains[i] > 0:
                lake = rains[i]
                if lake in full_lakes:
                    return []
                full_lakes[lake] = i
                ans[i] = -1
            else:
                dry_days.append(i)

        for lake, day in full_lakes.items():

            found = False
            for j in range(len(dry_days)):
                if dry_days[j] > day:
                    ans[dry_days[j]] = lake
                    dry_days.pop(j)
                    found = True
                    break
            if not found:
                return []

        return ans
class Solution:
    def intersectionSizeTwo(self, intervals: list[list[int]]) -> int:
        intervals.sort(key=lambda x: (x[1], -x[0]))
        ans = 0
        chosen = []
        for interval in intervals:
            start, end = interval
            need = 0
            for p in chosen:
                if start <= p <= end:
                    need += 1
            if need == 2:
                continue
            elif need == 1:
                ans += 1
                chosen.append(end)
            else:
                ans += 2
                chosen.append(end - 1)
                chosen.append(end)
            chosen = sorted(list(set(chosen)))
            while len(chosen) > 2 and chosen[0] < interval[0]:
                chosen.pop(0)
        return ans
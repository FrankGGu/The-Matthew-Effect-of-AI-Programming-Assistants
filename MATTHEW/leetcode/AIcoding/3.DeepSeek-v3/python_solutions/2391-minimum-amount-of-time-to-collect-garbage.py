class Solution:
    def garbageCollection(self, garbage: List[str], travel: List[int]) -> int:
        time = 0
        last_m = last_p = last_g = -1

        for i in range(len(garbage)):
            if 'M' in garbage[i]:
                last_m = i
            if 'P' in garbage[i]:
                last_p = i
            if 'G' in garbage[i]:
                last_g = i
            time += len(garbage[i])

        for i in range(1, len(travel)):
            travel[i] += travel[i - 1]

        if last_m > 0:
            time += travel[last_m - 1]
        if last_p > 0:
            time += travel[last_p - 1]
        if last_g > 0:
            time += travel[last_g - 1]

        return time
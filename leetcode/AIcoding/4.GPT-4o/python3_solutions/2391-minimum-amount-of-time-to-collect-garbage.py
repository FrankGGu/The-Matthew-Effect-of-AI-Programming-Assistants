class Solution:
    def minimumTimeToCollectGarbage(self, garbage: List[str], travel: List[int]) -> int:
        total_time = sum(len(g) for g in garbage)
        last_truck = {'M': -1, 'P': -1, 'G': -1}

        for i, g in enumerate(garbage):
            for c in g:
                last_truck[c] = i

        for i in range(3):
            if i == 0 and last_truck['M'] != -1:
                total_time += sum(travel[j] for j in range(last_truck['M']))
            elif i == 1 and last_truck['P'] != -1:
                total_time += sum(travel[j] for j in range(last_truck['P']))
            elif i == 2 and last_truck['G'] != -1:
                total_time += sum(travel[j] for j in range(last_truck['G']))

        return total_time
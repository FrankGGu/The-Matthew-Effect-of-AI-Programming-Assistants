class Solution:
    def garbageCollection(self, garbage: list[str], travel: list[int]) -> int:
        total_time = 0

        last_m_idx = -1
        last_p_idx = -1
        last_g_idx = -1

        for i in range(len(garbage)):
            house_garbage = garbage[i]
            total_time += len(house_garbage)

            if 'M' in house_garbage:
                last_m_idx = i
            if 'P' in house_garbage:
                last_p_idx = i
            if 'G' in house_garbage:
                last_g_idx = i

        prefix_travel = [0] * (len(travel) + 1)
        for i in range(len(travel)):
            prefix_travel[i+1] = prefix_travel[i] + travel[i]

        if last_m_idx != -1:
            total_time += prefix_travel[last_m_idx]
        if last_p_idx != -1:
            total_time += prefix_travel[last_p_idx]
        if last_g_idx != -1:
            total_time += prefix_travel[last_g_idx]

        return total_time
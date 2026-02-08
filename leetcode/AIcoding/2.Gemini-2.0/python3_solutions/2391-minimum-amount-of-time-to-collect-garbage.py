class Solution:
    def garbageCollection(self, garbage: List[str], travel: List[int]) -> int:
        last_g = -1
        last_p = -1
        last_m = -1
        total_g = 0
        total_p = 0
        total_m = 0
        n = len(garbage)
        for i in range(n):
            g_count = garbage[i].count('G')
            p_count = garbage[i].count('P')
            m_count = garbage[i].count('M')
            if g_count > 0:
                last_g = i
            if p_count > 0:
                last_p = i
            if m_count > 0:
                last_m = i
            total_g += g_count
            total_p += p_count
            total_m += m_count

        travel_g = 0
        travel_p = 0
        travel_m = 0
        for i in range(n - 1):
            if i < last_g:
                travel_g += travel[i]
            if i < last_p:
                travel_p += travel[i]
            if i < last_m:
                travel_m += travel[i]

        return total_g + total_p + total_m + travel_g + travel_p + travel_m
class Solution:
    def countTime(self, time: str) -> int:
        h1, h2, _, m1, m2 = time
        count_h = 0
        for h in range(24):
            h_str = f"{h:02d}"
            if (h1 == '?' or h1 == h_str[0]) and (h2 == '?' or h2 == h_str[1]):
                count_h += 1
        count_m = 0
        for m in range(60):
            m_str = f"{m:02d}"
            if (m1 == '?' or m1 == m_str[0]) and (m2 == '?' or m2 == m_str[1]):
                count_m += 1
        return count_h * count_m
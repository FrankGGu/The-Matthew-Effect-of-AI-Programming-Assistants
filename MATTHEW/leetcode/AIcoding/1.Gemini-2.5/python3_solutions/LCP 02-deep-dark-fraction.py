import math

class Solution:
    def deepDarkFraction(self, n: int) -> list[int]:
        a0 = int(math.sqrt(n))

        if a0 * a0 == n:
            return [a0]

        result = [a0]

        m_prev = 0
        d_prev = 1
        a_prev = a0 

        seen = {}

        k = 0 

        while True:
            m_curr = d_prev * a_prev - m_prev
            d_curr = (n - m_curr * m_curr) // d_prev
            a_curr = (a0 + m_curr) // d_curr

            if (m_curr, d_curr) in seen:
                break

            seen[(m_curr, d_curr)] = k
            result.append(a_curr)

            m_prev = m_curr
            d_prev = d_curr
            a_prev = a_curr
            k += 1

        return result
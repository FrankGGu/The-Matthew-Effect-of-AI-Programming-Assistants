class Solution:
    def minNumberOfFrogs(self, croak: str) -> int:
        c_waiting_r = 0
        r_waiting_o = 0
        o_waiting_a = 0
        a_waiting_k = 0

        max_frogs = 0
        current_active_frogs = 0

        for char in croak:
            if char == 'c':
                c_waiting_r += 1
                current_active_frogs += 1
                max_frogs = max(max_frogs, current_active_frogs)
            elif char == 'r':
                if c_waiting_r == 0:
                    return -1
                c_waiting_r -= 1
                r_waiting_o += 1
            elif char == 'o':
                if r_waiting_o == 0:
                    return -1
                r_waiting_o -= 1
                o_waiting_a += 1
            elif char == 'a':
                if o_waiting_a == 0:
                    return -1
                o_waiting_a -= 1
                a_waiting_k += 1
            elif char == 'k':
                if a_waiting_k == 0:
                    return -1
                a_waiting_k -= 1
                current_active_frogs -= 1

        if c_waiting_r > 0 or r_waiting_o > 0 or o_waiting_a > 0 or a_waiting_k > 0:
            return -1

        return max_frogs
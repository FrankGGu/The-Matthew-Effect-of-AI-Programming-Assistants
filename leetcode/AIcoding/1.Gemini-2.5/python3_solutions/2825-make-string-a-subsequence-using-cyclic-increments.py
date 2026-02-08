class Solution:
    def canBeSubsequence(self, s: str, target: str) -> bool:
        n = len(s)
        m = len(target)

        if m == 0:
            return True

        target_ptr = 0

        for s_char_idx in range(n):
            if target_ptr < m:
                s_char = s[s_char_idx]
                t_char = target[target_ptr]

                ord_s = ord(s_char) - ord('a')
                ord_t = ord(t_char) - ord('a')

                # Check if t_char can be formed from s_char by 0, 1, or 2 cyclic increments
                if ord_t == ord_s or \
                   ord_t == (ord_s + 1) % 26 or \
                   ord_t == (ord_s + 2) % 26:
                    target_ptr += 1
            else:
                # All characters of target have been found
                break

        return target_ptr == m
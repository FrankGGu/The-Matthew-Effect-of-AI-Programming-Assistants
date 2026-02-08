class Solution:
    def canMakePalindromeQueries(self, s: str, queries: List[List[int]]) -> List[bool]:
        n = len(s)
        m = n // 2
        t = s[m:][::-1] if n % 2 == 0 else s[m+1:][::-1]
        s_half = s[:m]

        # Precompute prefix differences
        diff = [0] * (m + 1)
        for i in range(m):
            diff[i+1] = diff[i] + (1 if s_half[i] != t[i] else 0)

        # Precompute prefix counts for s_half and t
        cnt_s = [[0] * 26 for _ in range(m + 1)]
        cnt_t = [[0] * 26 for _ in range(m + 1)]
        for i in range(m):
            for c in range(26):
                cnt_s[i+1][c] = cnt_s[i][c]
                cnt_t[i+1][c] = cnt_t[i][c]
            cnt_s[i+1][ord(s_half[i]) - ord('a')] += 1
            cnt_t[i+1][ord(t[i]) - ord('a')] += 1

        res = []
        for a, b, c, d in queries:
            c_prime = n - 1 - d
            d_prime = n - 1 - c
            left = min(a, c_prime)
            right = max(b, d_prime)

            # Check if outside ranges are already matching
            if left > 0 and diff[left] != 0:
                res.append(False)
                continue
            if right + 1 < m and diff[m] - diff[right+1] != 0:
                res.append(False)
                continue

            # Compute the character counts in the ranges
            s_start = max(a, c_prime)
            s_end = min(b, d_prime)
            s_cnt = [0] * 26
            t_cnt = [0] * 26
            if s_start <= s_end:
                for i in range(26):
                    s_cnt[i] = cnt_s[s_end+1][i] - cnt_s[s_start][i]
                    t_cnt[i] = cnt_t[s_end+1][i] - cnt_t[s_start][i]
            else:
                # No overlap, need to check both ranges
                if a <= b:
                    for i in range(26):
                        s_cnt[i] += cnt_s[b+1][i] - cnt_s[a][i]
                if c_prime <= d_prime:
                    for i in range(26):
                        t_cnt[i] += cnt_t[d_prime+1][i] - cnt_t[c_prime][i]

            # Check if counts match
            match = True
            for i in range(26):
                if s_cnt[i] != t_cnt[i]:
                    match = False
                    break
            res.append(match)
        return res
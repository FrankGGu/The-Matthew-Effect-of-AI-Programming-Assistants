class Solution:
    def maxProduct(self, s: str) -> int:
        n = len(s)

        lps_lengths = [0] * (1 << n)

        for mask in range(1, 1 << n):
            current_sub_str_list = []
            for j in range(n):
                if (mask >> j) & 1:
                    current_sub_str_list.append(s[j])

            current_sub_str = "".join(current_sub_str_list)
            m = len(current_sub_str)

            if m == 0:
                continue

            dp = [[0] * m for _ in range(m)]

            for i in range(m):
                dp[i][i] = 1

            for length in range(2, m + 1):
                for i in range(m - length + 1):
                    j = i + length - 1
                    if current_sub_str[i] == current_sub_str[j]:
                        if length == 2:
                            dp[i][j] = 2
                        else:
                            dp[i][j] = 2 + dp[i+1][j-1]
                    else:
                        dp[i][j] = max(dp[i+1][j], dp[i][j-1])

            lps_lengths[mask] = dp[0][m-1]

        max_prod = 0

        for mask1 in range(1, 1 << n):
            len1 = lps_lengths[mask1]

            for mask2 in range(1, 1 << n):
                if (mask1 & mask2) == 0:
                    len2 = lps_lengths[mask2]
                    max_prod = max(max_prod, len1 * len2)

        return max_prod
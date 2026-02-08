class Solution:
    def numWays(self, words: list[str], target: str) -> int:
        MOD = 10**9 + 7

        n_target = len(target)
        m_word_len = len(words[0])

        counts = [[0] * m_word_len for _ in range(26)]
        for word in words:
            for j in range(m_word_len):
                counts[ord(word[j]) - ord('a')][j] += 1

        dp_prev = [1] * (m_word_len + 1)

        for i in range(1, n_target + 1):
            char_to_match = target[i-1]
            char_code = ord(char_to_match) - ord('a')

            dp_curr = [0] * (m_word_len + 1)

            for j in range(1, m_word_len + 1):
                dp_curr[j] = dp_curr[j-1]

                ways_to_use_col_j_minus_1 = counts[char_code][j-1] * dp_prev[j-1]

                dp_curr[j] = (dp_curr[j] + ways_to_use_col_j_minus_1) % MOD

            dp_prev = dp_curr

        return dp_prev[m_word_len]
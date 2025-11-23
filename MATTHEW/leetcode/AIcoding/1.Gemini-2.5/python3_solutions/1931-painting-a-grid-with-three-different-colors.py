class Solution:
    def paintGrid(self, m: int, n: int) -> int:
        MOD = 10**9 + 7

        def generate_patterns(rows):
            patterns = []
            def backtrack(row_idx, current_pattern):
                if row_idx == rows:
                    patterns.append(tuple(current_pattern))
                    return

                for color in range(3):
                    if row_idx > 0 and color == current_pattern[row_idx - 1]:
                        continue
                    current_pattern.append(color)
                    backtrack(row_idx + 1, current_pattern)
                    current_pattern.pop()

            backtrack(0, [])
            return patterns

        valid_patterns = generate_patterns(m)
        num_patterns = len(valid_patterns)

        adj_matrix = [[False] * num_patterns for _ in range(num_patterns)]

        def check_adjacent(pattern1, pattern2, rows):
            for k in range(rows):
                if pattern1[k] == pattern2[k]:
                    return False
            return True

        for i in range(num_patterns):
            for j in range(num_patterns):
                if check_adjacent(valid_patterns[i], valid_patterns[j], m):
                    adj_matrix[i][j] = True

        dp_prev = [1] * num_patterns

        for _ in range(1, n):
            dp_curr = [0] * num_patterns
            for p_idx_curr in range(num_patterns):
                for p_idx_prev in range(num_patterns):
                    if adj_matrix[p_idx_prev][p_idx_curr]:
                        dp_curr[p_idx_curr] = (dp_curr[p_idx_curr] + dp_prev[p_idx_prev]) % MOD
            dp_prev = dp_curr

        total_ways = sum(dp_prev) % MOD
        return total_ways
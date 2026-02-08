class Solution:
    def colorTheGrid(self, m: int, n: int) -> int:
        MOD = 10**9 + 7

        def get_valid_states(m):
            states = []
            def backtrack(curr, index):
                if index == m:
                    states.append(curr)
                    return

                for color in range(1, 4):
                    if index > 0 and color == curr[-1]:
                        continue
                    backtrack(curr + [color], index + 1)

            backtrack([], 0)
            return states

        states = get_valid_states(m)
        num_states = len(states)

        adj_matrix = [[0] * num_states for _ in range(num_states)]

        for i in range(num_states):
            for j in range(num_states):
                valid = True
                for k in range(m):
                    if states[i][k] == states[j][k]:
                        valid = False
                        break
                if valid:
                    adj_matrix[i][j] = 1

        dp = [1] * num_states

        for _ in range(n - 1):
            new_dp = [0] * num_states
            for i in range(num_states):
                for j in range(num_states):
                    if adj_matrix[j][i] == 1:
                        new_dp[i] = (new_dp[i] + dp[j]) % MOD
            dp = new_dp

        return sum(dp) % MOD
class Solution:
    def numberOfWays(self, corridor: str) -> int:
        MOD = 10**9 + 7

        s_indices = []
        for i, char in enumerate(corridor):
            if char == 'S':
                s_indices.append(i)

        num_plants = len(s_indices)

        if num_plants == 0 or num_plants % 2 != 0:
            return 0

        ways = 1

        for i in range(1, num_plants // 2):
            ways = (ways * (s_indices[2*i] - s_indices[2*i - 1])) % MOD

        return ways
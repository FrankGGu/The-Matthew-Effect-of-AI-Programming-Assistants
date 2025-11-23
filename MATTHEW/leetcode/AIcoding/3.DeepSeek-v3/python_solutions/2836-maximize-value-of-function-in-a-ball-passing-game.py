class Solution:
    def getMaxFunctionValue(self, receiver: List[int], k: int) -> int:
        n = len(receiver)
        m = k.bit_length()
        parent = [[0] * n for _ in range(m)]
        value = [[0] * n for _ in range(m)]

        for i in range(n):
            parent[0][i] = receiver[i]
            value[0][i] = receiver[i]

        for j in range(1, m):
            for i in range(n):
                parent[j][i] = parent[j-1][parent[j-1][i]]
                value[j][i] = value[j-1][i] + value[j-1][parent[j-1][i]]

        max_value = 0
        for i in range(n):
            current = i
            total = i
            remaining = k
            for j in range(m):
                if remaining & (1 << j):
                    total += value[j][current]
                    current = parent[j][current]
            max_value = max(max_value, total)

        return max_value
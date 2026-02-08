class Solution:
    def minimumOperations(self, n: int, num2: int) -> int:
        for m in range(1, 65):
            current_target = n - m

            if current_target < m:
                break

            pop_count = bin(current_target).count('1')

            if pop_count <= m:
                return m

        return -1
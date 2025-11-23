class Solution:
    def lexicalOrder(self, n: int) -> list[int]:
        result = []

        def dfs(curr):
            if curr > n:
                return

            result.append(curr)

            # Explore numbers formed by appending a '0' (going deeper in the lexicographical tree)
            # E.g., from 1 to 10, from 10 to 100.
            if curr * 10 <= n:
                dfs(curr * 10)

            # Explore the next number in the current 'level' (going sideways in the lexicographical tree)
            # E.g., from 1 to 2, from 10 to 11.
            # This condition ensures:
            # 1. We don't go from a number ending in 9 (like 9, 19) to the next (10, 20) directly.
            #    Numbers like 10, 20 are handled by the `curr * 10` call from their respective prefixes (1, 2).
            # 2. We don't exceed `n`.
            if curr % 10 != 9 and curr + 1 <= n:
                dfs(curr + 1)

        # Start the DFS from each single-digit number (1 to 9)
        # These are the roots of the lexicographical trees.
        for i in range(1, 10):
            dfs(i)

        return result
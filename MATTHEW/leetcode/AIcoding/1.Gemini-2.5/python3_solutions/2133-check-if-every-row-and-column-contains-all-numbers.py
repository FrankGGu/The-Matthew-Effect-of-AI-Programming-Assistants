class Solution:
    def checkValid(self, matrix: list[list[int]]) -> bool:
        n = len(matrix)

        # Check rows
        for r in range(n):
            seen = [False] * (n + 1)
            for c in range(n):
                num = matrix[r][c]
                if not (1 <= num <= n) or seen[num]:
                    return False
                seen[num] = True

            # After checking all numbers in the row, ensure all numbers from 1 to n were seen
            # This is implicitly handled by the `seen[num]` check and the `(1 <= num <= n)` check.
            # If any number was out of range or duplicated, we would have returned False.
            # If all numbers were unique and in range, then `n` distinct numbers were seen.
            # We can also explicitly check that `n` numbers were marked True, but it's redundant.
            # For example: if sum(seen[1:]) != n: return False (but this is not needed)

        # Check columns
        for c in range(n):
            seen = [False] * (n + 1)
            for r in range(n):
                num = matrix[r][c]
                if not (1 <= num <= n) or seen[num]:
                    return False
                seen[num] = True

        return True
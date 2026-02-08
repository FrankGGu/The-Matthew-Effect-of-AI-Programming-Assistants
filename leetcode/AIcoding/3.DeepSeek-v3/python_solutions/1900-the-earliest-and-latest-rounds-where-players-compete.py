class Solution:
    def earliestAndLatest(self, n: int, firstPlayer: int, secondPlayer: int) -> List[int]:
        first = firstPlayer - 1
        second = secondPlayer - 1

        def dfs(mask, round, left, right):
            if left >= right:
                return dfs(mask, round, 0, n - 1)
            if (mask >> left) & 1 == 0:
                return dfs(mask, round, left + 1, right)
            if (mask >> right) & 1 == 0:
                return dfs(mask, round, left, right - 1)
            if left == right:
                return dfs(mask, round, 0, n - 1)
            if left == first and right == second:
                return (round, round)
            new_mask = mask
            if left == first or left == second:
                new_mask &= ~(1 << right)
            elif right == first or right == second:
                new_mask &= ~(1 << left)
            else:
                new_mask &= ~(1 << right)
            return dfs(new_mask, round, left + 1, right - 1)

        earliest, latest = dfs((1 << n) - 1, 1, 0, n - 1)
        return [earliest, latest]
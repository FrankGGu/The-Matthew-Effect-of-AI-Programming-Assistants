class Solution:
    def kthSmallestInstructions(self, n: int, k: int) -> List[str]:
        from math import comb

        path = []
        left, right = n, n
        k -= 1

        for _ in range(2 * n - 2):
            if left > 0:
                # Number of ways to arrange remaining steps if we move left
                ways = comb(left + right - 1, left - 1)
                if k < ways:
                    path.append('D')
                    left -= 1
                else:
                    path.append('R')
                    k -= ways
                    right -= 1
            else:
                path.append('R')
                right -= 1

        return ''.join(path)
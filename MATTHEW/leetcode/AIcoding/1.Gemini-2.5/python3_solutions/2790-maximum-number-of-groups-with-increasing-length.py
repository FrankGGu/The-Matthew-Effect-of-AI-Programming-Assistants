import math

class Solution:
    def maximumGroups(self, n: int) -> int:
        # We need to find the maximum k such that the sum of lengths from 1 to k
        # is less than or equal to n.
        # The sum of lengths is 1 + 2 + ... + k = k * (k + 1) / 2.
        # So we need to find the largest integer k such that:
        # k * (k + 1) / 2 <= n
        # k * (k + 1) <= 2 * n
        # k^2 + k - 2n <= 0

        # We can solve this quadratic inequality for k.
        # The roots of k^2 + k - 2n = 0 are given by the quadratic formula:
        # k = (-1 +/- sqrt(1 - 4 * 1 * (-2n))) / 2
        # k = (-1 +/- sqrt(1 + 8n)) / 2

        # Since k must be positive (number of groups), we take the positive root:
        # k = (-1 + sqrt(1 + 8n)) / 2

        # We need the largest integer k that satisfies the inequality,
        # so we take the floor of this value.

        # Calculate the square root of (1 + 8n)
        # Using math.isqrt for integer square root to avoid floating point precision issues.
        sqrt_val = math.isqrt(1 + 8 * n)

        # Calculate k using integer division (floor)
        k = (-1 + sqrt_val) // 2

        return k
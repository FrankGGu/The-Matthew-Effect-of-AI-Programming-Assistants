import math

class Solution:
    def maximumGroups(self, grades: list[int]) -> int:
        n = len(grades)

        # The problem asks to maximize the number of groups 'k' such that
        # 1. The number of members in group_i is strictly less than group_{i+1}.
        # 2. The sum of grades in group_i is strictly less than group_{i+1}.
        # 3. All grades must be used.

        # To maximize 'k', we should make the group sizes as small as possible while
        # satisfying the strictly increasing condition.
        # The smallest possible group sizes are 1, 2, 3, ..., k.

        # The total number of grades required for 'k' groups with these sizes is
        # 1 + 2 + ... + k = k * (k + 1) / 2.

        # Since all 'n' grades must be used, we must have:
        # k * (k + 1) / 2 <= n

        # We need to find the largest integer 'k' that satisfies this inequality.
        # Rearranging the inequality:
        # k^2 + k <= 2n
        # k^2 + k - 2n <= 0

        # To find the maximum 'k', we can solve the quadratic equation k^2 + k - 2n = 0.
        # Using the quadratic formula, k = (-b +/- sqrt(b^2 - 4ac)) / 2a
        # Here, a=1, b=1, c=-2n.
        # k = (-1 +/- sqrt(1^2 - 4 * 1 * (-2n))) / 2 * 1
        # k = (-1 +/- sqrt(1 + 8n)) / 2

        # Since 'k' must be a positive number (number of groups), we take the positive root:
        # k = (-1 + sqrt(1 + 8n)) / 2

        # The largest integer 'k' satisfying the inequality will be the floor of this value.
        # The actual 'grades' values are not needed for this calculation.
        # If we sort the grades, we can always satisfy the sum condition by assigning
        # the smallest available grades to the smaller groups. Since group_{i+1} has
        # more members than group_i, and we are picking from a sorted list, its sum
        # will naturally be greater.

        discriminant = 1 + 8 * n
        k_float = (-1 + math.sqrt(discriminant)) / 2

        return math.floor(k_float)
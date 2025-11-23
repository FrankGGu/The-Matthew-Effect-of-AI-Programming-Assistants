class Solution:
    def getMinimumTravelTime(self, locations: list[list[int]], costPerMinute: int) -> int:
        locations.sort()
        n = len(locations)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + locations[i][0]

        def calculate_cost(left, right, center_index):
            return (prefix_sum[right + 1] - prefix_sum[center_index + 1] - locations[center_index][0] * (right - center_index)) + (locations[center_index][0] * (center_index - left) - (prefix_sum[center_index] - prefix_sum[left]))

        dp = {}

        def solve(left, right):
            if left >= right:
                return 0

            if (left, right) in dp:
                return dp[(left, right)]

            ans = float('inf')
            for i in range(left, right + 1):
                cost = calculate_cost(left, right, i)
                ans = min(ans, locations[i][1] + cost * costPerMinute + solve(left, i - 1) + solve(i + 1, right))

            dp[(left, right)] = ans
            return ans

        return solve(0, n - 1)
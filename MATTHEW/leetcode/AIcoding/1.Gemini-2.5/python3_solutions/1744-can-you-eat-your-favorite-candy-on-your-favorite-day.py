class Solution:
    def canEat(self, candiesCount: list[int], queries: list[list[int]]) -> list[bool]:
        n = len(candiesCount)

        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i+1] = prefix_sum[i] + candiesCount[i]

        results = []
        for candyType, day, dailyCap in queries:
            # Condition 1: Minimum number of candies eaten by the end of 'day' (eating 1 candy per day)
            # must be enough to reach 'candyType'.
            # 'prefix_sum[candyType]' is the total count of candies before 'candyType'.
            # If we eat 1 candy per day, by the end of 'day', we've eaten 'day + 1' candies.
            # To reach 'candyType', we must have eaten more than 'prefix_sum[candyType]' candies.
            # So, (day + 1) > prefix_sum[candyType].
            can_reach_candy_type = (day + 1) > prefix_sum[candyType]

            # Condition 2: Maximum number of candies eaten by the end of 'day - 1' (eating 'dailyCap' candies per day)
            # must not exceed the total count of candies up to and including 'candyType'.
            # 'prefix_sum[candyType + 1]' is the total count of candies up to and including 'candyType'.
            # If we eat 'dailyCap' candies per day, by the end of 'day - 1', we've eaten 'day * dailyCap' candies.
            # To have 'candyType' available on 'day', 'day * dailyCap' must be less than 'prefix_sum[candyType + 1]'.
            # If 'day * dailyCap' is greater than or equal to 'prefix_sum[candyType + 1]',
            # all candies of 'candyType' would have been consumed before 'day'.
            candy_available = (day * dailyCap) < prefix_sum[candyType + 1]

            results.append(can_reach_candy_type and candy_available)

        return results
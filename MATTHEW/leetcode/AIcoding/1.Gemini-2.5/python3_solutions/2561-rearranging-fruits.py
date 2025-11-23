import collections

class Solution:
    def minCost(self, basket1: list[int], basket2: list[int]) -> int:
        c1 = collections.Counter(basket1)
        c2 = collections.Counter(basket2)

        total_counts = collections.Counter()
        total_counts.update(c1)
        total_counts.update(c2)

        min_overall_fruit = float('inf')

        for fruit, count in total_counts.items():
            if count % 2 != 0:
                return -1
            min_overall_fruit = min(min_overall_fruit, fruit)

        fruits_from_b1_to_b2 = []
        fruits_from_b2_to_b1 = []

        for fruit, total_count in total_counts.items():
            target_half = total_count // 2

            excess_in_b1 = c1[fruit] - target_half
            excess_in_b2 = c2[fruit] - target_half

            if excess_in_b1 > 0:
                fruits_from_b1_to_b2.extend([fruit] * excess_in_b1)

            if excess_in_b2 > 0:
                fruits_from_b2_to_b1.extend([fruit] * excess_in_b2)

        fruits_from_b1_to_b2.sort()
        fruits_from_b2_to_b1.sort()

        cost = 0
        k = len(fruits_from_b1_to_b2)

        for i in range(k):
            x = fruits_from_b1_to_b2[i]
            y = fruits_from_b2_to_b1[i]

            cost += min(min(x, y), 2 * min_overall_fruit)

        return cost
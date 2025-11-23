class Solution:
    def maxSpending(self, items: list[list[int]]) -> int:
        all_costs = []
        for category in items:
            for cost in category:
                all_costs.append(cost)

        all_costs.sort(reverse=True)

        total_spending = 0
        num_items = len(all_costs)

        for i in range(num_items):
            # The i-th most expensive item (0-indexed) is bought on day (num_items - i)
            # For example, the most expensive item (i=0) is bought on day num_items.
            # The second most expensive item (i=1) is bought on day num_items - 1.
            # The least expensive item (i=num_items-1) is bought on day 1.
            day = num_items - i
            total_spending += all_costs[i] * day

        return total_spending
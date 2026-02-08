import heapq

class Solution:
    def findMaximumElegance(self, items: list[list[int]], k: int) -> int:
        # Sort items by profit in descending order
        items.sort(key=lambda x: x[0], reverse=True)

        current_profit = 0
        seen_categories = set()
        # Min-heap to store profits of items that are duplicates in terms of category
        # These are candidates for removal to make space for a new category item
        duplicate_profits_heap = [] 

        # 1. Select the initial k items with the highest profits
        for i in range(k):
            profit, category = items[i]
            current_profit += profit
            if category in seen_categories:
                heapq.heappush(duplicate_profits_heap, profit)
            else:
                seen_categories.add(category)

        # Calculate initial elegance
        max_elegance = current_profit + len(seen_categories)**2

        # 2. Iterate through the remaining items (those with lower profits)
        # Try to swap a duplicate-category item from our selection with a new-category item
        for i in range(k, len(items)):
            profit, category = items[i]

            # If this item introduces a new category AND we have a duplicate item to remove
            if category not in seen_categories:
                if duplicate_profits_heap:
                    # Remove the smallest profit item from our current selection that is a duplicate
                    smallest_duplicate_profit = heapq.heappop(duplicate_profits_heap)

                    # Update current_profit: remove old, add new
                    current_profit = current_profit - smallest_duplicate_profit + profit

                    # Add the new category
                    seen_categories.add(category)

                    # Update max_elegance
                    max_elegance = max(max_elegance, current_profit + len(seen_categories)**2)
                else:
                    # No duplicate items to remove. We cannot increase distinct categories
                    # without removing a distinct-category item, which would decrease C.
                    # Since we are iterating through items of decreasing profit,
                    # any further swap would only decrease profit or not increase C.
                    # So, we can stop.
                    break
            # If the category is already in seen_categories, this item doesn't help increase distinct categories.
            # Since it has lower profit than items already considered,
            # adding it would only decrease profit or just add another duplicate. So, we ignore it.

        return max_elegance
#include <vector>
#include <algorithm>
#include <unordered_set>

struct Item {
    int profit;
    int category;
};

bool compareItems(const Item& a, const Item& b) {
    return a.profit > b.profit;
}

class Solution {
public:
    long long findMaximumElegance(std::vector<std::vector<int>>& items_vec, int k) {
        std::vector<Item> items;
        for (const auto& item_data : items_vec) {
            items.push_back({item_data[0], item_data[1]});
        }

        // Sort items by profit in descending order
        std::sort(items.begin(), items.end(), compareItems);

        long long current_profit_sum = 0;
        std::unordered_set<int> seen_categories;
        // Stores profits of items with duplicate categories from the initial k selection.
        // We sort this vector to easily remove the smallest profit.
        std::vector<long long> duplicate_profits_to_remove; 

        // 1. Initial selection of k items with highest profits
        for (int i = 0; i < k; ++i) {
            current_profit_sum += items[i].profit;
            if (seen_categories.count(items[i].category)) {
                duplicate_profits_to_remove.push_back(items[i].profit);
            } else {
                seen_categories.insert(items[i].category);
            }
        }

        // Sort duplicate_profits_to_remove in ascending order.
        // This allows us to use pop_back() to get the smallest profit (for removal).
        std::sort(duplicate_profits_to_remove.begin(), duplicate_profits_to_remove.end());

        long long max_elegance = current_profit_sum + (long long)seen_categories.size() * seen_categories.size();

        // 2. Iterate through remaining items (from index k to n-1) to potentially swap
        // We try to replace an item with a duplicate category (smallest profit)
        // with an item that introduces a new category (highest profit among remaining).
        for (int i = k; i < items.size(); ++i) {
            int p_new = items[i].profit;
            int c_new = items[i].category;

            // Condition for a beneficial swap:
            // 1. The new item's category (c_new) must be truly new (not in seen_categories).
            // 2. We must have an item with a duplicate category in our current k selection
            //    that we can remove to make space for the new unique category.
            //    (i.e., duplicate_profits_to_remove must not be empty).
            if (!seen_categories.count(c_new) && !duplicate_profits_to_remove.empty()) {
                long long p_old = duplicate_profits_to_remove.back(); // Smallest profit from a duplicate category item
                duplicate_profits_to_remove.pop_back();

                current_profit_sum = current_profit_sum - p_old + p_new;
                seen_categories.insert(c_new);
                // The number of unique categories implicitly increases by 1

                max_elegance = std::max(max_elegance, current_profit_sum + (long long)seen_categories.size() * seen_categories.size());
            }
            // If c_new is already in seen_categories, adding it won't increase unique categories.
            // Since items are sorted by profit descending, p_new will be less than or equal to p_old
            // (p_old came from the initial k items, p_new from subsequent items).
            // Replacing any item would only decrease or maintain profit sum without increasing unique categories.
            // If duplicate_profits_to_remove is empty, it means all k items currently selected have unique categories.
            // In this case, we cannot increase unique categories further. Any swap would decrease profit sum.
            // So, we only consider swaps that increase unique categories.
        }

        return max_elegance;
    }
};
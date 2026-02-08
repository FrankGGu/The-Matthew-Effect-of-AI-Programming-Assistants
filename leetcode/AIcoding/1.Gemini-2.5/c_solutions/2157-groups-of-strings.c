#include <vector>
#include <string>
#include <numeric>
#include <unordered_map>
#include <algorithm>

std::vector<int> parent;
std::vector<int> group_total_size; // Stores the sum of counts of strings for each root

int find_set(int v) {
    if (v == parent[v])
        return v;
    return parent[v] = find_set(parent[v]);
}

void union_sets(int a, int b) {
    a = find_set(a);
    b = find_set(b);
    if (a != b) {
        // Union by size: attach smaller tree under root of larger tree
        if (group_total_size[a] < group_total_size[b])
            std::swap(a, b);
        parent[b] = a;
        group_total_size[a] += group_total_size[b];
    }
}

class Solution {
public:
    std::vector<int> groupsOfStrings(std::vector<std::string>& words) {
        // Clear global DSU structures for a new test case
        parent.clear();
        group_total_size.clear();

        std::unordered_map<int, int> mask_to_id; // map bitmask to its DSU index
        std::vector<int> initial_mask_counts; // stores count of each unique mask, indexed by DSU id

        // Step 1: Process words, create unique masks, and initialize DSU structures
        for (const std::string& word : words) {
            int mask = 0;
            for (char c : word) {
                mask |= (1 << (c - 'a'));
            }

            if (mask_to_id.find(mask) == mask_to_id.end()) {
                // If this mask is new, assign it a new DSU id
                mask_to_id[mask] = parent.size(); 
                parent.push_back(parent.size()); // Initialize parent for this new id (self-parent)
                initial_mask_counts.push_back(1); // First occurrence of this mask
            } else {
                // If mask exists, increment its count
                initial_mask_counts[mask_to_id[mask]]++; 
            }
        }

        // Initialize group_total_size with the counts of unique masks.
        // Each unique mask initially forms a group of its own, with its count.
        group_total_size = initial_mask_counts;

        // Step 2: Iterate through unique masks and establish connections
        for (auto const& [mask, id] : mask_to_id) {
            // Case 1: Add/Delete one character
            // Check masks that differ by exactly one bit (e.g., "a" <-> "ab")
            for (int i = 0; i < 26; ++i) {
                int neighbor_mask = mask ^ (1 << i); // Flip i-th bit
                if (mask_to_id.count(neighbor_mask)) {
                    union_sets(id, mask_to_id[neighbor_mask]);
                }
            }

            // Case 2: Replace one character
            // Check masks that differ by exactly two bits (one bit removed, one bit added)
            // (e.g., "ac" <-> "bc")
            for (int i = 0; i < 26; ++i) { // Character to potentially remove (bit i)
                if (mask & (1 << i)) { // If i-th character is present in current mask
                    int temp_mask = mask ^ (1 << i); // Mask after removing char i
                    for (int j = 0; j < 26; ++j) { // Character to potentially add (bit j)
                        if (!(temp_mask & (1 << j))) { // If j-th character is not present in temp_mask
                            int neighbor_mask = temp_mask | (1 << j); // Mask after adding char j
                            if (mask_to_id.count(neighbor_mask)) {
                                union_sets(id, mask_to_id[neighbor_mask]);
                            }
                        }
                    }
                }
            }
        }

        // Step 3: Calculate number of groups and maximum group size
        int num_groups = 0;
        int max_group_size = 0;
        for (int i = 0; i < parent.size(); ++i) {
            if (parent[i] == i) { // If i is a root of a group
                num_groups++;
                max_group_size = std::max(max_group_size, group_total_size[i]);
            }
        }

        return {num_groups, max_group_size};
    }
};
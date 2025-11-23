#include <vector>
#include <numeric> // For std::iota
#include <queue>

std::vector<int> topoSort(const std::vector<std::vector<int>>& adj, std::vector<int> indegree, const std::vector<int>& nodes_to_process) {
    std::queue<int> q;
    for (int node : nodes_to_process) {
        if (indegree[node] == 0) {
            q.push(node);
        }
    }

    std::vector<int> result;
    int processed_count = 0; // Count nodes from nodes_to_process that have been added to result

    while (!q.empty()) {
        int u = q.front();
        q.pop();
        result.push_back(u);
        processed_count++;

        for (int v : adj[u]) {
            indegree[v]--;
            if (indegree[v] == 0) {
                q.push(v);
            }
        }
    }

    if (processed_count == nodes_to_process.size()) {
        return result;
    } else {
        return {}; // Cycle detected
    }
}

class Solution {
public:
    std::vector<int> sortItems(int n, int m, std::vector<int>& group, const std::vector<std::vector<int>>& beforeItems) {
        // 1. Normalize Group IDs: Assign unique group IDs to items not belonging to any group (-1).
        // New group IDs start from 'm'
        int current_group_id = m;
        for (int i = 0; i < n; ++i) {
            if (group[i] == -1) {
                group[i] = current_group_id++;
            }
        }
        int total_groups = current_group_id;

        // 2. Initialize Data Structures
        // Item-level graph
        std::vector<std::vector<int>> adj_item(n);
        std::vector<int> indegree_item(n, 0);

        // Group-level graph
        std::vector<std::vector<int>> adj_group(total_groups);
        std::vector<int> indegree_group(total_groups, 0);

        // Store items belonging to each group
        std::vector<std::vector<int>> items_in_group(total_groups);

        // 3. Build Graphs
        for (int i = 0; i < n; ++i) {
            items_in_group[group[i]].push_back(i);

            for (int prev_item : beforeItems[i]) {
                // Item dependency: prev_item -> i
                adj_item[prev_item].push_back(i);
                indegree_item[i]++;

                // Group dependency: group[prev_item] -> group[i] if they are different groups
                if (group[prev_item] != group[i]) {
                    adj_group[group[prev_item]].push_back(group[i]);
                    indegree_group[group[i]]++;
                }
            }
        }

        // 4. Topological Sort for Items within Groups
        std::vector<std::vector<int>> sorted_items_in_group(total_groups);
        for (int g = 0; g < total_groups; ++g) {
            std::vector<int> current_group_items = items_in_group[g];
            if (current_group_items.empty()) {
                continue; // No items in this group
            }

            // Calculate local indegrees for items within this specific group
            std::vector<int> group_local_indegree(n, 0); 
            for (int item_u : current_group_items) {
                for (int item_v : adj_item[item_u]) {
                    if (group[item_v] == g) { // Only count dependencies within the same group
                        group_local_indegree[item_v]++;
                    }
                }
            }

            std::queue<int> q_item_local;
            for (int item_u : current_group_items) {
                if (group_local_indegree[item_u] == 0) {
                    q_item_local.push(item_u);
                }
            }

            std::vector<int> current_group_sorted_items;
            int processed_items_count = 0;
            while (!q_item_local.empty()) {
                int u = q_item_local.front();
                q_item_local.pop();
                current_group_sorted_items.push_back(u);
                processed_items_count++;

                for (int v : adj_item[u]) {
                    if (group[v] == g) { // Only process dependencies within the same group
                        group_local_indegree[v]--;
                        if (group_local_indegree[v] == 0) {
                            q_item_local.push(v);
                        }
                    }
                }
            }

            if (processed_items_count != current_group_items.size()) {
                return {}; // Cycle detected within this group
            }
            sorted_items_in_group[g] = current_group_sorted_items;
        }

        // 5. Topological Sort for Groups
        std::vector<int> all_group_ids(total_groups);
        std::iota(all_group_ids.begin(), all_group_ids.end(), 0); // Fills with 0, 1, ..., total_groups-1

        std::vector<int> sorted_groups = topoSort(adj_group, indegree_group, all_group_ids);
        if (sorted_groups.empty() && total_groups > 0) { // If total_groups is 0, sorted_groups will be empty, which is fine
            return {}; // Cycle detected among groups
        }

        // 6. Combine Results
        std::vector<int> final_sorted_list;
        for (int group_id : sorted_groups) {
            for (int item_id : sorted_items_in_group[group_id]) {
                final_sorted_list.push_back(item_id);
            }
        }

        return final_sorted_list;
    }
};
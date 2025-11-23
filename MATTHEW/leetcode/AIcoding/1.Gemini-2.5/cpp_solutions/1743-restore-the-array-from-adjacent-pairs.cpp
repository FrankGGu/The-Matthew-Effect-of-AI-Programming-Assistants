#include <vector>
#include <unordered_map>

class Solution {
public:
    std::vector<int> restoreArray(std::vector<std::vector<int>>& adjacentPairs) {
        std::unordered_map<int, std::vector<int>> adj;
        for (const auto& pair : adjacentPairs) {
            adj[pair[0]].push_back(pair[1]);
            adj[pair[1]].push_back(pair[0]);
        }

        int start_node = -1;
        for (const auto& entry : adj) {
            if (entry.second.size() == 1) {
                start_node = entry.first;
                break;
            }
        }

        int n = adjacentPairs.size() + 1;
        std::vector<int> result(n);
        result[0] = start_node;

        int prev = start_node;
        // The second element in the array is the only neighbor of the start_node.
        // This is safe because start_node has exactly one neighbor.
        int current = adj[start_node][0]; 

        for (int i = 1; i < n; ++i) {
            result[i] = current;

            // If we just added the last element (result[n-1]), we are done.
            // No need to find a 'next' element.
            if (i == n - 1) {
                break; 
            }

            // Find the next element.
            // 'current' (which is result[i]) has two neighbors.
            // One is 'prev' (result[i-1]), the other is 'next' (result[i+1]).
            int next;
            if (adj[current][0] == prev) {
                next = adj[current][1];
            } else {
                next = adj[current][0];
            }

            prev = current;
            current = next;
        }

        return result;
    }
};
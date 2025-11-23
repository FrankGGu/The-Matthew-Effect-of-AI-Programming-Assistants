#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    std::vector<int> get_distances(int start_node, int n, const std::vector<int>& edges) {
        std::vector<int> distances(n, std::numeric_limits<int>::max());
        int current_dist = 0;
        int current_node = start_node;

        while (current_node != -1 && distances[current_node] == std::numeric_limits<int>::max()) {
            distances[current_node] = current_dist;
            current_node = edges[current_node];
            current_dist++;
        }
        return distances;
    }

    int closestMeetingNode(std::vector<int>& edges, int node1, int node2) {
        int n = edges.size();

        std::vector<int> dist1 = get_distances(node1, n, edges);
        std::vector<int> dist2 = get_distances(node2, n, edges);

        int min_max_dist = std::numeric_limits<int>::max();
        int result_node = -1;

        for (int i = 0; i < n; ++i) {
            if (dist1[i] != std::numeric_limits<int>::max() && dist2[i] != std::numeric_limits<int>::max()) {
                int current_max_dist = std::max(dist1[i], dist2[i]);
                if (current_max_dist < min_max_dist) {
                    min_max_dist = current_max_dist;
                    result_node = i;
                }
            }
        }

        return result_node;
    }
};
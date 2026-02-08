#include <vector>
#include <algorithm>
#include <map>
#include <tuple>

using namespace std;

const int MOD = 1e9 + 7;

struct Node {
    int count; // Number of active rectangles covering this segment
    long long length; // Total length covered by active rectangles within this node's range
    int y_low_idx; // Index in y_coords_unique for the lower bound of this node's range
    int y_high_idx; // Index in y_coords_unique for the upper bound of this node's range
};

vector<Node> tree;
vector<int> y_coords_unique;

void build(int node_idx, int y_low_idx, int y_high_idx) {
    tree[node_idx].y_low_idx = y_low_idx;
    tree[node_idx].y_high_idx = y_high_idx;
    tree[node_idx].count = 0;
    tree[node_idx].length = 0;

    if (y_low_idx + 1 == y_high_idx) { // Leaf node, represents a single elementary y-interval
        return;
    }

    int mid_idx = y_low_idx + (y_high_idx - y_low_idx) / 2;
    build(2 * node_idx, y_low_idx, mid_idx);
    build(2 * node_idx + 1, mid_idx, y_high_idx);
}

void update(int node_idx, int query_y_low_idx, int query_y_high_idx, int delta) {
    // If the current node's range is completely outside the query range
    if (tree[node_idx].y_low_idx >= query_y_high_idx || tree[node_idx].y_high_idx <= query_y_low_idx) {
        return;
    }

    // If the current node's range is completely inside the query range
    if (tree[node_idx].y_low_idx >= query_y_low_idx && tree[node_idx].y_high_idx <= query_y_high_idx) {
        tree[node_idx].count += delta;
    } else { // Partial overlap, recurse to children
        update(2 * node_idx, query_y_low_idx, query_y_high_idx, delta);
        update(2 * node_idx + 1, query_y_low_idx, query_y_high_idx, delta);
    }

    // Recalculate length for the current node
    if (tree[node_idx].count > 0) { // This node's entire range is covered
        tree[node_idx].length = y_coords_unique[tree[node_idx].y_high_idx] - y_coords_unique[tree[node_idx].y_low_idx];
    } else { // This node's range is not fully covered by its own count
        if (tree[node_idx].y_low_idx + 1 == tree[node_idx].y_high_idx) { // Leaf node
            tree[node_idx].length = 0;
        } else { // Internal node, sum lengths from children
            tree[node_idx].length = tree[2 * node_idx].length + tree[2 * node_idx + 1].length;
        }
    }
}

class Solution {
public:
    int rectangleArea(vector<vector<int>>& rectangles) {
        vector<tuple<int, int, int, int>> events; // x, y1, y2, type (+1 for start, -1 for end)
        y_coords_unique.clear(); // Clear for each test case

        for (const auto& rect : rectangles) {
            int x1 = rect[0], y1 = rect[1], x2 = rect[2], y2 = rect[3];
            events.emplace_back(x1, y1, y2, 1);  // Left edge event
            events.emplace_back(x2, y1, y2, -1); // Right edge event
            y_coords_unique.push_back(y1);
            y_coords_unique.push_back(y2);
        }

        sort(events.begin(), events.end()); // Sort events by x-coordinate, then by type (+1 before -1)

        sort(y_coords_unique.begin(), y_coords_unique.end());
        y_coords_unique.erase(unique(y_coords_unique.begin(), y_coords_unique.end()), y_coords_unique.end());

        // Map y-coordinates to their indices in y_coords_unique for segment tree
        map<int, int> y_to_idx;
        for (int i = 0; i < y_coords_unique.size(); ++i) {
            y_to_idx[y_coords_unique[i]] = i;
        }

        int num_y_coords = y_coords_unique.size();
        // If there's only one unique y-coordinate (e.g., all rectangles are lines), no area can be formed.
        if (num_y_coords < 2) {
            return 0;
        }

        // Max segment tree size: 4 * (number of elementary y-intervals)
        // Number of elementary y-intervals is num_y_coords - 1.
        tree.assign(4 * num_y_coords, Node()); 
        build(1, 0, num_y_coords - 1); // Build segment tree over indices 0 to num_y_coords-1

        long long total_area = 0;
        int prev_x = get<0>(events[0]);

        for (const auto& event : events) {
            int curr_x = get<0>(event);
            int y1 = get<1>(event);
            int y2 = get<2>(event);
            int type = get<3>(event);

            long long width = curr_x - prev_x;
            if (width > 0) {
                // Add area for the strip: width * total covered y-length
                total_area = (total_area + width * tree[1].length) % MOD;
            }

            // Update segment tree for the current event
            int y1_idx = y_to_idx[y1];
            int y2_idx = y_to_idx[y2];
            // Update the segment tree for the range of y-indices [y1_idx, y2_idx)
            update(1, y1_idx, y2_idx, type);

            prev_x = curr_x;
        }

        return total_area;
    }
};
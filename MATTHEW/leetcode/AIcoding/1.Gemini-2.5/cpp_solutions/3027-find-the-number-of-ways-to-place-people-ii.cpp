#include <vector>
#include <algorithm>
#include <map>

class FenwickTree {
public:
    // Constructor initializes the tree with a given size.
    // Size here refers to the maximum possible compressed y-coordinate + 1.
    // The tree itself is 1-indexed, so we allocate size + 1.
    FenwickTree(int size) : tree(size + 1, 0), size_(size) {}

    // Updates the Fenwick tree by adding 'delta' to the element at 'idx'.
    // 'idx' is 0-indexed, so we convert it to 1-indexed for BIT operations.
    void update(int idx, int delta) {
        idx++; // Convert to 1-indexed
        while (idx <= size_) {
            tree[idx] += delta;
            idx += idx & (-idx); // Move to the next relevant index
        }
    }

    // Queries the sum of elements from index 0 up to 'idx' (inclusive).
    // 'idx' is 0-indexed, so we convert it to 1-indexed for BIT operations.
    int query(int idx) {
        idx++; // Convert to 1-indexed
        int sum = 0;
        while (idx > 0) {
            sum += tree[idx];
            idx -= idx & (-idx); // Move to the parent index
        }
        return sum;
    }

private:
    std::vector<int> tree;
    int size_; // Maximum 1-indexed value in the tree
};

struct Point {
    int x, y;
};

bool comparePoints(const Point& a, const Point& b) {
    if (a.x != b.x) {
        return a.x < b.x;
    }
    return a.y < b.y;
}

class Solution {
public:
    int numberOfWays(std::vector<std::vector<int>>& points) {
        // Step 1: Convert input vector<vector<int>> to vector<Point> for easier sorting
        std::vector<Point> pts;
        for (const auto& p_arr : points) {
            pts.push_back({p_arr[0], p_arr[1]});
        }

        // Step 2: Sort the points
        // The sorting order is crucial: x-ascending, then y-ascending.
        // This ensures that if point A comes before point B in the sorted list (i.e., A.index < B.index),
        // then A.x <= B.x. If A.x == B.x, then A.y <= B.y.
        // This property is used in the sweep-line approach with Fenwick tree.
        std::sort(pts.begin(), pts.end(), comparePoints);

        // Step 3: Coordinate compression for y-coordinates
        // Collect all unique y-coordinates to map them to smaller, contiguous indices.
        std::vector<int> y_coords;
        for (const auto& p : pts) {
            y_coords.push_back(p.y);
        }
        std::sort(y_coords.begin(), y_coords.end());
        // Remove duplicate y-coordinates to get unique sorted values
        y_coords.erase(std::unique(y_coords.begin(), y_coords.end()), y_coords.end());

        // Create a map from original y-value to its compressed 0-indexed coordinate
        std::map<int, int> y_to_compressed_idx;
        for (int i = 0; i < y_coords.size(); ++i) {
            y_to_compressed_idx[y_coords[i]] = i;
        }

        // M is the number of unique y-coordinates, which defines the size of our Fenwick tree.
        int M = y_coords.size();
        FenwickTree ft(M);
        long long total_ways = 0;

        // Step 4: Iterate through the sorted points and use Fenwick tree
        // For each point P_i = (x_i, y_i) in the sorted list:
        // We want to count points P_k = (x_k, y_k) that appeared *before* P_i in the sorted list
        // such that P_k can be placed top-left of P_i.
        // This means x_k <= x_i and y_k <= y_i.
        // Since P_k appeared before P_i, x_k <= x_i is guaranteed by the primary sort key (x-ascending).
        // If x_k == x_i, then y_k <= y_i is also guaranteed by the secondary sort key (y-ascending).
        // Therefore, we just need to count P_k such that y_k <= y_i.
        // The Fenwick tree stores counts of y-coordinates of points processed so far.
        for (const auto& p : pts) {
            int compressed_y = y_to_compressed_idx[p.y];
            // Query the Fenwick tree for the count of y-coordinates less than or equal to p.y.
            // These are the points P_k that satisfy y_k <= p.y and x_k <= p.x.
            total_ways += ft.query(compressed_y);
            // Add the current point's y-coordinate to the Fenwick tree.
            ft.update(compressed_y, 1);
        }

        return static_cast<int>(total_ways);
    }
};
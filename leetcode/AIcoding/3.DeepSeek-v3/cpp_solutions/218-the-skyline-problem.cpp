class Solution {
public:
    vector<vector<int>> getSkyline(vector<vector<int>>& buildings) {
        vector<pair<int, int>> edges;
        for (const auto& b : buildings) {
            edges.emplace_back(b[0], -b[2]);
            edges.emplace_back(b[1], b[2]);
        }
        sort(edges.begin(), edges.end());

        multiset<int> heights = {0};
        vector<vector<int>> result;
        int prev = 0;

        for (const auto& e : edges) {
            int x = e.first;
            int h = e.second;

            if (h < 0) {
                heights.insert(-h);
            } else {
                heights.erase(heights.find(h));
            }

            int curr = *heights.rbegin();
            if (curr != prev) {
                result.push_back({x, curr});
                prev = curr;
            }
        }

        return result;
    }
};
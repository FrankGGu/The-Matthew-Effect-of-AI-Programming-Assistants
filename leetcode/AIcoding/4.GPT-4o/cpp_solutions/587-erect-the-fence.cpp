class Solution {
public:
    vector<vector<int>> outerTrees(vector<vector<int>>& trees) {
        int n = trees.size();
        if (n <= 1) return trees;

        sort(trees.begin(), trees.end());

        vector<vector<int>> hull;

        for (int i = 0; i < n; i++) {
            while (hull.size() >= 2 && cross(hull[hull.size() - 2], hull[hull.size() - 1], trees[i]) < 0) {
                hull.pop_back();
            }
            hull.push_back(trees[i]);
        }

        int t = hull.size();
        for (int i = n - 1; i >= 0; i--) {
            while (hull.size() > t && cross(hull[hull.size() - 2], hull[hull.size() - 1], trees[i]) < 0) {
                hull.pop_back();
            }
            hull.push_back(trees[i]);
        }

        hull.pop_back();

        set<vector<int>> uniquePoints(hull.begin(), hull.end());
        return vector<vector<int>>(uniquePoints.begin(), uniquePoints.end());
    }

private:
    long long cross(const vector<int>& O, const vector<int>& A, const vector<int>& B) {
        return (long long)(A[0] - O[0]) * (B[1] - O[1]) - (long long)(A[1] - O[1]) * (B[0] - O[0]);
    }
};
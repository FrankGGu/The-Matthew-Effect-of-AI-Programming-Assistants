class Solution {
public:
    int maxPoints(vector<vector<int>>& points) {
        int n = points.size();
        if (n <= 2) return n;
        int res = 0;
        for (int i = 0; i < n; ++i) {
            unordered_map<string, int> count;
            int same = 1;
            int max_count = 0;
            for (int j = i + 1; j < n; ++j) {
                int x1 = points[i][0], y1 = points[i][1];
                int x2 = points[j][0], y2 = points[j][1];
                if (x1 == x2 && y1 == y2) {
                    ++same;
                } else {
                    int dx = x2 - x1, dy = y2 - y1;
                    int g = gcd(dx, dy);
                    string key = to_string(dx / g) + "_" + to_string(dy / g);
                    ++count[key];
                    max_count = max(max_count, count[key]);
                }
            }
            res = max(res, max_count + same);
        }
        return res;
    }

private:
    int gcd(int a, int b) {
        return b == 0 ? a : gcd(b, a % b);
    }
};
class Solution {
public:
    bool isRectangleCover(vector<vector<int>>& rectangles) {
        unordered_map<string, int> count;
        int area = 0, x1 = INT_MAX, y1 = INT_MAX, x2 = INT_MIN, y2 = INT_MIN;

        for (auto& r : rectangles) {
            area += (r[2] - r[0]) * (r[3] - r[1]);
            x1 = min(x1, r[0]);
            y1 = min(y1, r[1]);
            x2 = max(x2, r[2]);
            y2 = max(y2, r[3]);

            count[to_string(r[0]) + "," + to_string(r[1])]++;
            count[to_string(r[0]) + "," + to_string(r[3])]++;
            count[to_string(r[2]) + "," + to_string(r[1])]++;
            count[to_string(r[2]) + "," + to_string(r[3])]++;
        }

        string corners = to_string(x1) + "," + to_string(y1) + "," +
                         to_string(x1) + "," + to_string(y2) + "," +
                         to_string(x2) + "," + to_string(y1) + "," +
                         to_string(x2) + "," + to_string(y2);

        if (count[corners] != 1) return false;

        for (auto& [key, value] : count) {
            if (value != 1 && value != 2) {
                if (key != to_string(x1) + "," + to_string(y1) && 
                    key != to_string(x1) + "," + to_string(y2) && 
                    key != to_string(x2) + "," + to_string(y1) && 
                    key != to_string(x2) + "," + to_string(y2)) {
                    return false;
                }
            }
        }

        return area == (x2 - x1) * (y2 - y1);
    }
};
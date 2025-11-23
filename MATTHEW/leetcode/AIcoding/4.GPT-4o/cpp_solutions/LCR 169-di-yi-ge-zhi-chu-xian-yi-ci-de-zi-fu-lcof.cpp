class Solution {
public:
    bool isRectangleCover(vector<vector<int>>& rectangles) {
        unordered_map<string, int> count;
        int area = 0;
        int x1 = INT_MAX, y1 = INT_MAX, x2 = INT_MIN, y2 = INT_MIN;

        for (auto& rect : rectangles) {
            area += (rect[2] - rect[0]) * (rect[3] - rect[1]);
            x1 = min(x1, rect[0]);
            y1 = min(y1, rect[1]);
            x2 = max(x2, rect[2]);
            y2 = max(y2, rect[3]);

            string corners[] = {
                to_string(rect[0]) + "_" + to_string(rect[1]),
                to_string(rect[0]) + "_" + to_string(rect[3]),
                to_string(rect[2]) + "_" + to_string(rect[1]),
                to_string(rect[2]) + "_" + to_string(rect[3])
            };
            for (string& corner : corners) {
                count[corner]++;
            }
        }

        if (area != (x2 - x1) * (y2 - y1)) return false;

        vector<string> expectedCorners = {
            to_string(x1) + "_" + to_string(y1),
            to_string(x1) + "_" + to_string(y2),
            to_string(x2) + "_" + to_string(y1),
            to_string(x2) + "_" + to_string(y2)
        };

        for (string& corner : expectedCorners) {
            if (count[corner] != 1) return false;
        }

        for (auto& [corner, cnt] : count) {
            if (find(expectedCorners.begin(), expectedCorners.end(), corner) == expectedCorners.end() && cnt % 2 != 0) 
                return false;
        }

        return true;
    }
};
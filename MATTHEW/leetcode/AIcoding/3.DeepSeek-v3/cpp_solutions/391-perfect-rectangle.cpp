class Solution {
public:
    bool isRectangleCover(vector<vector<int>>& rectangles) {
        unordered_map<string, int> corners;
        int minX = INT_MAX, minY = INT_MAX, maxX = INT_MIN, maxY = INT_MIN;
        long area = 0;

        for (auto& rect : rectangles) {
            int x1 = rect[0], y1 = rect[1], x2 = rect[2], y2 = rect[3];
            minX = min(minX, x1);
            minY = min(minY, y1);
            maxX = max(maxX, x2);
            maxY = max(maxY, y2);
            area += (long)(x2 - x1) * (y2 - y1);

            string cornersList[4] = {
                to_string(x1) + " " + to_string(y1),
                to_string(x1) + " " + to_string(y2),
                to_string(x2) + " " + to_string(y1),
                to_string(x2) + " " + to_string(y2)
            };

            for (string corner : cornersList) {
                if (++corners[corner] > 4) return false;
            }
        }

        string outerCorners[4] = {
            to_string(minX) + " " + to_string(minY),
            to_string(minX) + " " + to_string(maxY),
            to_string(maxX) + " " + to_string(minY),
            to_string(maxX) + " " + to_string(maxY)
        };

        for (string corner : outerCorners) {
            if (corners[corner] != 1) return false;
        }

        for (auto& pair : corners) {
            string corner = pair.first;
            int count = pair.second;
            if (count != 2 && count != 4 && 
                corner != outerCorners[0] && 
                corner != outerCorners[1] && 
                corner != outerCorners[2] && 
                corner != outerCorners[3]) {
                return false;
            }
        }

        return area == (long)(maxX - minX) * (maxY - minY);
    }
};
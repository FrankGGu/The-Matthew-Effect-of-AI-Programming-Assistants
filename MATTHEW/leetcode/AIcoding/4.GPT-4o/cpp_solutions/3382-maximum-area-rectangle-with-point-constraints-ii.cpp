class Solution {
public:
    int maxRectangleArea(vector<vector<int>>& points) {
        set<int> x_coords, y_coords;
        for (const auto& point : points) {
            x_coords.insert(point[0]);
            y_coords.insert(point[1]);
        }

        vector<int> x_vec(x_coords.begin(), x_coords.end());
        vector<int> y_vec(y_coords.begin(), y_coords.end());

        int max_area = 0;

        for (int i = 0; i < x_vec.size(); ++i) {
            for (int j = i + 1; j < x_vec.size(); ++j) {
                for (int k = 0; k < y_vec.size(); ++k) {
                    for (int l = k + 1; l < y_vec.size(); ++l) {
                        if (pointsSet.count({x_vec[i], y_vec[k]}) && 
                            pointsSet.count({x_vec[i], y_vec[l]}) && 
                            pointsSet.count({x_vec[j], y_vec[k]}) && 
                            pointsSet.count({x_vec[j], y_vec[l]})) {
                            max_area = max(max_area, (x_vec[j] - x_vec[i]) * (y_vec[l] - y_vec[k]));
                        }
                    }
                }
            }
        }

        return max_area;
    }
};
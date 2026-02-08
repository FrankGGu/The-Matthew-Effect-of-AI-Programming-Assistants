#include <vector>
#include <cmath>

class Solution {
public:
    std::vector<std::vector<int>> fillMissingData(std::vector<std::vector<int>>& data) {
        if (data.empty() || data[0].empty()) {
            return data;
        }

        int rows = data.size();
        int cols = data[0].size();

        for (int j = 0; j < cols; ++j) {
            long long sum = 0;
            int count = 0;

            for (int i = 0; i < rows; ++i) {
                if (data[i][j] != -1) {
                    sum += data[i][j];
                    count++;
                }
            }

            if (count > 0) {
                double average = static_cast<double>(sum) / count;
                int rounded_average = static_cast<int>(std::round(average));

                for (int i = 0; i < rows; ++i) {
                    if (data[i][j] == -1) {
                        data[i][j] = rounded_average;
                    }
                }
            }
        }

        return data;
    }
};
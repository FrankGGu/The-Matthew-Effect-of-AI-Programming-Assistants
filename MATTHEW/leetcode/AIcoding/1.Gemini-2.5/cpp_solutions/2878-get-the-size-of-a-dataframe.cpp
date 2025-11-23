#include <vector>

class Solution {
public:
    std::vector<int> getDataFrameSize(std::vector<std::vector<int>>& data) {
        int rows = data.size();
        int cols = 0;
        if (rows > 0) {
            cols = data[0].size();
        }
        return {rows, cols};
    }
};
#include <vector>

class Solution {
public:
    int numComfortable(std::vector<int>& humidities, int lower, int upper) {
        int count = 0;
        for (int h : humidities) {
            if (h >= lower && h <= upper) {
                count++;
            }
        }
        return count;
    }
};
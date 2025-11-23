#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    double averageValue(vector<int>& nums) {
        vector<int> filteredNums;
        for (int num : nums) {
            if (num % 2 == 0 && num % 3 == 0) {
                filteredNums.push_back(num);
            }
        }

        if (filteredNums.empty()) {
            return 0.0;
        }

        double sum = accumulate(filteredNums.begin(), filteredNums.end(), 0.0);
        return sum / filteredNums.size();
    }
};
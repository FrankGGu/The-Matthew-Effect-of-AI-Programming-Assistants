#include <vector>
using namespace std;

class Solution {
public:
    vector<int> grayCode(int n) {
        vector<int> result = {0};
        for (int i = 0; i < n; ++i) {
            int size = result.size();
            for (int j = size - 1; j >= 0; --j) {
                result.push_back(result[j] | (1 << i));
            }
        }
        return result;
    }
};
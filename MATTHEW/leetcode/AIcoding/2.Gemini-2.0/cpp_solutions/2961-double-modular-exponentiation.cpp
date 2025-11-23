#include <vector>

using namespace std;

class Solution {
public:
    vector<int> getGoodIndices(vector<vector<int>>& variables, int target) {
        vector<int> goodIndices;
        for (int i = 0; i < variables.size(); ++i) {
            long long a = variables[i][0];
            long long b = variables[i][1];
            long long c = variables[i][2];
            long long m = variables[i][3];

            long long first = 1;
            for (int j = 0; j < b; ++j) {
                first = (first * a) % 10;
            }

            long long second = 1;
            for (int j = 0; j < c; ++j) {
                second = (second * first) % m;
            }

            if (second == target) {
                goodIndices.push_back(i);
            }
        }
        return goodIndices;
    }
};
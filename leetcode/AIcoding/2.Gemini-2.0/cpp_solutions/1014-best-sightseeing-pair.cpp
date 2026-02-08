#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxScoreSightseeingPair(vector<int>& values) {
        int max_so_far = values[0] + 0;
        int max_score = 0;
        for (int j = 1; j < values.size(); ++j) {
            max_score = max(max_score, max_so_far + values[j] - j);
            max_so_far = max(max_so_far, values[j] + j);
        }
        return max_score;
    }
};
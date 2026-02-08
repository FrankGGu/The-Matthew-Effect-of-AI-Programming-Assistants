#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> findStudentsWhoImproved(vector<vector<int>>& grades) {
        vector<int> result;
        for (int i = 0; i < grades.size(); ++i) {
            if (grades[i][1] > grades[i][0]) {
                result.push_back(i);
            }
        }
        return result;
    }
};
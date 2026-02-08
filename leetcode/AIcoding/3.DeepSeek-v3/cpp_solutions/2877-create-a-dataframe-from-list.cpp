#include <vector>
#include <string>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<string>> createDataFrame(vector<string>& names, vector<int>& ages, vector<int>& scores) {
        vector<vector<string>> result;
        result.push_back({"Name", "Age", "Score"});
        for (int i = 0; i < names.size(); ++i) {
            result.push_back({names[i], to_string(ages[i]), to_string(scores[i])});
        }
        return result;
    }
};
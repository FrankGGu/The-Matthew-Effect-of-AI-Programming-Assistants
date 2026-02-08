#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string findReplaceString(string s, vector<int>& indices, vector<string>& sources, vector<string>& targets) {
        vector<pair<int, int>> sorted_indices;
        for (int i = 0; i < indices.size(); ++i) {
            sorted_indices.push_back({indices[i], i});
        }
        sort(sorted_indices.begin(), sorted_indices.end());

        string result = "";
        int current_index = 0;
        for (int i = 0; i < sorted_indices.size(); ++i) {
            int index = sorted_indices[i].first;
            int original_index = sorted_indices[i].second;
            string source = sources[original_index];
            string target = targets[original_index];

            result += s.substr(current_index, index - current_index);
            if (s.substr(index, source.length()) == source) {
                result += target;
                current_index = index + source.length();
            } else {
                result += s.substr(index, source.length());
                current_index = index + source.length();
            }

        }
        result += s.substr(current_index);
        return result;
    }
};
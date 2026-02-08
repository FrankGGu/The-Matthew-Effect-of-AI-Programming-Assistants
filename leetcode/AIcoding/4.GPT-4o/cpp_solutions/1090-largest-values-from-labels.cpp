#include <vector>
#include <algorithm>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> largestValuesFromLabels(vector<int>& values, vector<int>& labels, int numWanted, int useLimit) {
        int n = values.size();
        vector<pair<int, int>> valueLabelPairs;

        for (int i = 0; i < n; ++i) {
            valueLabelPairs.emplace_back(values[i], labels[i]);
        }

        sort(valueLabelPairs.rbegin(), valueLabelPairs.rend());

        unordered_map<int, int> labelCount;
        vector<int> result;

        for (const auto& pair : valueLabelPairs) {
            int value = pair.first;
            int label = pair.second;

            if (labelCount[label] < useLimit && result.size() < numWanted) {
                result.push_back(value);
                labelCount[label]++;
            }
        }

        return result;
    }
};
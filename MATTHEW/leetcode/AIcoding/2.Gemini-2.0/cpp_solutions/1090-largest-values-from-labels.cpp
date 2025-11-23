#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int largestValsFromLabels(vector<int>& values, vector<int>& labels, int num_wanted, int use_limit) {
        int n = values.size();
        vector<pair<int, int>> items;
        for (int i = 0; i < n; ++i) {
            items.push_back({values[i], labels[i]});
        }

        sort(items.begin(), items.end(), greater<pair<int, int>>());

        int sum = 0;
        int count = 0;
        map<int, int> label_counts;

        for (int i = 0; i < n && count < num_wanted; ++i) {
            int value = items[i].first;
            int label = items[i].second;

            if (label_counts[label] < use_limit) {
                sum += value;
                label_counts[label]++;
                count++;
            }
        }

        return sum;
    }
};
using namespace std;

class Solution {
public:
    int largestValsFromLabels(vector<int>& values, vector<int>& labels, int numWanted, int useLimit) {
        int n = values.size();
        vector<pair<int, int>> items;
        for (int i = 0; i < n; ++i) {
            items.push_back({values[i], labels[i]});
        }
        sort(items.begin(), items.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.first > b.first;
        });

        unordered_map<int, int> labelCount;
        int sum = 0;
        int count = 0;
        for (int i = 0; i < n && count < numWanted; ++i) {
            int value = items[i].first;
            int label = items[i].second;
            if (labelCount[label] < useLimit) {
                sum += value;
                labelCount[label]++;
                count++;
            }
        }
        return sum;
    }
};
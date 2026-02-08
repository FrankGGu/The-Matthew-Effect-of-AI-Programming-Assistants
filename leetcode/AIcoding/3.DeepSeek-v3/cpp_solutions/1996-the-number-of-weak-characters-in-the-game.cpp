class Solution {
public:
    int numberOfWeakCharacters(vector<vector<int>>& properties) {
        sort(properties.begin(), properties.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[0] == b[0] ? a[1] > b[1] : a[0] < b[0];
        });
        int res = 0;
        int maxDefense = 0;
        for (int i = properties.size() - 1; i >= 0; --i) {
            if (properties[i][1] < maxDefense) {
                res++;
            }
            maxDefense = max(maxDefense, properties[i][1]);
        }
        return res;
    }
};
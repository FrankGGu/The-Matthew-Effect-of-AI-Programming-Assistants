class Solution {
public:
    vector<int> pancakeSort(vector<int>& arr) {
        vector<int> res;
        int n = arr.size();
        for (int i = n; i > 0; --i) {
            int pos = find(arr.begin(), arr.end(), i) - arr.begin();
            if (pos == i - 1) continue;
            if (pos != 0) {
                res.push_back(pos + 1);
                reverse(arr.begin(), arr.begin() + pos + 1);
            }
            res.push_back(i);
            reverse(arr.begin(), arr.begin() + i);
        }
        return res;
    }
};
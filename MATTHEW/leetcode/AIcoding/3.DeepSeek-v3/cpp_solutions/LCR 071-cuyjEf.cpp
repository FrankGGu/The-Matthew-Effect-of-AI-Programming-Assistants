class Solution {
private:
    vector<int> prefix;
    int total;
public:
    Solution(vector<int>& w) {
        prefix.resize(w.size());
        prefix[0] = w[0];
        for (int i = 1; i < w.size(); ++i) {
            prefix[i] = prefix[i-1] + w[i];
        }
        total = prefix.back();
    }

    int pickIndex() {
        int r = rand() % total;
        auto it = upper_bound(prefix.begin(), prefix.end(), r);
        return it - prefix.begin();
    }
};
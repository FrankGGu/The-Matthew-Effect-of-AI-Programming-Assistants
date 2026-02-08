class Solution {
public:
    int getLastMoment(int n, vector<int>& left, vector<int>& right) {
        int last = 0;
        if (!left.empty()) {
            last = max(last, *max_element(left.begin(), left.end()));
        }
        if (!right.empty()) {
            last = max(last, n - *min_element(right.begin(), right.end()));
        }
        return last;
    }
};
class Solution {
public:
    int closestToTarget(vector<int>& arr, int target) {
        int res = INT_MAX;
        unordered_set<int> s;
        for (int num : arr) {
            unordered_set<int> tmp;
            tmp.insert(num);
            for (int val : s) {
                tmp.insert(val & num);
            }
            for (int val : tmp) {
                res = min(res, abs(val - target));
            }
            s = tmp;
        }
        return res;
    }
};
class Solution {
public:
    int closestToTarget(vector<int>& arr, int target) {
        unordered_set<int> s;
        int res = INT_MAX;
        for (int num : arr) {
            unordered_set<int> temp;
            temp.insert(num);
            for (int val : s) {
                temp.insert(val & num);
            }
            for (int val : temp) {
                res = min(res, abs(val - target));
            }
            s = temp;
        }
        return res;
    }
};
class Solution {
public:
    int subarrayBitwiseORs(vector<int>& arr) {
        unordered_set<int> res;
        unordered_set<int> cur;
        for (int num : arr) {
            unordered_set<int> next;
            next.insert(num);
            for (int val : cur) {
                next.insert(val | num);
            }
            cur = next;
            for (int val : cur) {
                res.insert(val);
            }
        }
        return res.size();
    }
};
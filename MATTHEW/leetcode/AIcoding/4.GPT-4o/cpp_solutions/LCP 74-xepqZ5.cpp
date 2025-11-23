class Solution {
public:
    int strongestForceField(vector<int>& strength, int k) {
        int n = strength.size();
        sort(strength.begin(), strength.end(), greater<int>());
        return accumulate(strength.begin(), strength.begin() + k, 0);
    }
};
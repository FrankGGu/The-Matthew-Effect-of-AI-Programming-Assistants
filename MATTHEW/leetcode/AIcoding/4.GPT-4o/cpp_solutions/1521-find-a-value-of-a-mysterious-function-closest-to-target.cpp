class Solution {
public:
    int closestToTarget(vector<int>& arr, int target) {
        unordered_set<int> currSet;
        int closest = INT_MAX;

        for (int num : arr) {
            unordered_set<int> newSet;
            newSet.insert(num);
            for (int x : currSet) {
                newSet.insert(x & num);
            }
            currSet = move(newSet);
            for (int x : currSet) {
                if (abs(x - target) < abs(closest - target) || 
                    (abs(x - target) == abs(closest - target) && x < closest)) {
                    closest = x;
                }
            }
        }
        return closest;
    }
};
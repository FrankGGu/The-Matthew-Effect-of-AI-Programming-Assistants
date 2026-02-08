class Solution {
public:
    bool mergeTriplets(vector<vector<int>>& triplets, vector<int>& target) {
        vector<int> res(3, 0);
        for (const auto& t : triplets) {
            if (t[0] <= target[0] && t[1] <= target[1] && t[2] <= target[2]) {
                res[0] = max(res[0], t[0]);
                res[1] = max(res[1], t[1]);
                res[2] = max(res[2], t[2]);
            }
        }
        return res == target;
    }
};
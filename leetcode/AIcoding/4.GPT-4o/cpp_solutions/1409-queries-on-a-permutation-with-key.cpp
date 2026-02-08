class Solution {
public:
    vector<int> findPermutation(vector<int>& perm, vector<vector<int>>& queries) {
        int n = perm.size();
        vector<int> result;
        for (auto& query : queries) {
            int left = query[0] - 1;
            int right = query[1] - 1;
            int key = query[2];
            vector<int> sub(perm.begin() + left, perm.begin() + right + 1);
            sort(sub.begin(), sub.end());
            result.push_back(sub[key - 1]);
        }
        return result;
    }
};
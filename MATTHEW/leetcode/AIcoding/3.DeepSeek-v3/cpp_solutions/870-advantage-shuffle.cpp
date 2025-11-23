class Solution {
public:
    vector<int> advantageCount(vector<int>& A, vector<int>& B) {
        multiset<int> s(A.begin(), A.end());
        vector<int> res;
        for (int i = 0; i < B.size(); ++i) {
            auto it = s.upper_bound(B[i]);
            if (it == s.end()) {
                it = s.begin();
            }
            res.push_back(*it);
            s.erase(it);
        }
        return res;
    }
};
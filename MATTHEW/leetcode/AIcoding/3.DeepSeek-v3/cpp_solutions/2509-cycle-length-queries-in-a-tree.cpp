class Solution {
public:
    vector<int> cycleLengthQueries(int n, vector<vector<int>>& queries) {
        vector<int> res;
        for (auto& q : queries) {
            int a = q[0], b = q[1];
            int len = 1;
            while (a != b) {
                if (a > b) {
                    a /= 2;
                } else {
                    b /= 2;
                }
                len++;
            }
            res.push_back(len);
        }
        return res;
    }
};
class Solution {
public:
    vector<string> buildArray(vector<int>& target, int n) {
        vector<string> res;
        int current = 1;
        for (int i = 0; i < target.size(); ++i) {
            while (current < target[i]) {
                res.push_back("Push");
                res.push_back("Pop");
                current++;
            }
            res.push_back("Push");
            current++;
        }
        return res;
    }
};
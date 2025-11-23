class Solution {
public:
    vector<string> buildArray(vector<int>& target, int n) {
        vector<string> res;
        int current = 1;
        for (int num : target) {
            while (current < num) {
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
class Solution {
public:
    vector<int> beautifulArray(int n) {
        vector<int> res = {1};
        while (res.size() < n) {
            vector<int> temp;
            for (int num : res) {
                if (2 * num - 1 <= n) {
                    temp.push_back(2 * num - 1);
                }
            }
            for (int num : res) {
                if (2 * num <= n) {
                    temp.push_back(2 * num);
                }
            }
            res = temp;
        }
        return res;
    }
};
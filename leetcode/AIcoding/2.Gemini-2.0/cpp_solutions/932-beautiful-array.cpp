#include <vector>

using namespace std;

class Solution {
public:
    vector<int> beautifulArray(int n) {
        vector<int> res = {1};
        while (res.size() < n) {
            vector<int> temp;
            for (int x : res) {
                if (x * 2 - 1 <= n) {
                    temp.push_back(x * 2 - 1);
                }
            }
            for (int x : res) {
                if (x * 2 <= n) {
                    temp.push_back(x * 2);
                }
            }
            res = temp;
        }
        return res;
    }
};
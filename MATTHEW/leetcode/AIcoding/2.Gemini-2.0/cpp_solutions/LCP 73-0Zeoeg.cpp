#include <vector>
#include <set>

using namespace std;

class Solution {
public:
    int expeditionCamp(vector<int>& supply) {
        int n = supply.size();
        set<int> s;
        s.insert(0);
        int ans = 0;
        for (int i = 0; i < n; ++i) {
            set<int> temp = s;
            for (int val : s) {
                temp.insert(val + supply[i]);
            }
            s = temp;
        }
        for (int val : s) {
            ans = max(ans, val);
        }
        return ans;
    }
};
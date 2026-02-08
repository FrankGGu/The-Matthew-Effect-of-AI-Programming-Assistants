#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<double> getCollisionTimes(vector<vector<int>>& cars) {
        int n = cars.size();
        vector<double> ans(n, -1.0);
        stack<int> s;

        for (int i = n - 1; i >= 0; --i) {
            while (!s.empty()) {
                int j = s.top();
                if (cars[i][1] <= cars[j][1]) {
                    s.pop();
                } else {
                    double time = (double)(cars[j][0] - cars[i][0]) / (cars[i][1] - cars[j][1]);
                    if (ans[j] == -1.0 || time <= ans[j]) {
                        ans[i] = time;
                        break;
                    } else {
                        s.pop();
                    }
                }
            }
            s.push(i);
        }

        return ans;
    }
};
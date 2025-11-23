#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int crossBridge(vector<int>& people) {
        int n = people.size();
        sort(people.begin(), people.end());
        int ans = 0;
        int i = n - 1;
        while (i >= 3) {
            ans += min(people[0] * 2 + people[i] + people[i - 1],
                       people[0] + people[1] * 2 + people[i]);
            i -= 2;
        }
        if (i == 2) {
            ans += people[0] + people[1] + people[2];
        } else if (i == 1) {
            ans += people[1];
        } else if (i == 0) {
            ans += people[0];
        }
        return ans;
    }
};
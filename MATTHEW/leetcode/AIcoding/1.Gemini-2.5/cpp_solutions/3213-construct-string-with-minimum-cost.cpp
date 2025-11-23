#include <string>

class Solution {
public:
    int minCost(std::string s, int cost) {
        int n = s.length();
        int ans = 0;
        for (int i = 0; i < n - 1; ++i) {
            if (s[i] == s[i + 1]) {
                int j = i + 1;
                int min_index = i;
                int max_cost = cost;

                if (cost < 0) return -1;

                while (j < n && s[i] == s[j]) {
                    if (cost > max_cost) {
                        max_cost = cost;
                        min_index = j;
                    }
                    j++;
                    if(j < n) cost = cost;
                    else break;
                }

                int k = i;
                while (k < j-1) {

                    ans += (k == min_index) ? 0 : cost;
                    k++;
                    if(k < j-1) cost = cost;
                    else break;
                }
                i = j - 1;
            }
        }
        return ans;
    }
};
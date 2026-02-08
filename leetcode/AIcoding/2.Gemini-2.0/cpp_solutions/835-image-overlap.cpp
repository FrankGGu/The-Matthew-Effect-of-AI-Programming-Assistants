#include <vector>

using namespace std;

class Solution {
public:
    int largestOverlap(vector<vector<int>>& img1, vector<vector<int>>& img2) {
        int n = img1.size();
        vector<int> list1, list2;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (img1[i][j] == 1) {
                    list1.push_back(i * n + j);
                }
                if (img2[i][j] == 1) {
                    list2.push_back(i * n + j);
                }
            }
        }

        int ans = 0;
        unordered_map<int, int> count;
        for (int i : list1) {
            for (int j : list2) {
                int diff = i - j;
                count[diff]++;
                ans = max(ans, count[diff]);
            }
        }

        return ans;
    }
};
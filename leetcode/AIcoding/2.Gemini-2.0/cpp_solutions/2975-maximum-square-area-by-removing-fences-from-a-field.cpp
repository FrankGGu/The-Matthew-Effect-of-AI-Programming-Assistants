#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeSquareArea(int m, int n, vector<int>& hFences, vector<int>& vFences) {
        hFences.push_back(1);
        hFences.push_back(m);
        vFences.push_back(1);
        vFences.push_back(n);

        sort(hFences.begin(), hFences.end());
        sort(vFences.begin(), vFences.end());

        vector<int> hDiffs;
        for (int i = 0; i < hFences.size(); ++i) {
            for (int j = i + 1; j < hFences.size(); ++j) {
                hDiffs.push_back(hFences[j] - hFences[i]);
            }
        }

        vector<int> vDiffs;
        for (int i = 0; i < vFences.size(); ++i) {
            for (int j = i + 1; j < vFences.size(); ++j) {
                vDiffs.push_back(vFences[j] - vFences[i]);
            }
        }

        long long maxArea = -1;
        for (int h : hDiffs) {
            for (int v : vDiffs) {
                if (h == v) {
                    maxArea = max(maxArea, (long long)h);
                }
            }
        }

        if (maxArea == -1) return -1;

        long long mod = 1e9 + 7;
        return (maxArea % mod * maxArea % mod) % mod;
    }
};
#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string kthSmallestPath(vector<int>& r, vector<int>& c, long long k) {
        int n = r.size();
        int m = c.size();
        string res;
        long long total = 1;
        for (int i = 0; i < n + m; ++i) {
            if (i < n) {
                total *= (n - i);
            } else {
                total *= (m - i + n);
            }
        }
        for (int i = 0; i < n + m; ++i) {
            if (i < n) {
                long long ways = 1;
                for (int j = 0; j < m; ++j) {
                    ways *= (n - i - 1 + m - j);
                    ways /= (j + 1);
                }
                if (k <= ways) {
                    res += 'U';
                } else {
                    res += 'D';
                    k -= ways;
                }
            } else {
                long long ways = 1;
                for (int j = 0; j < n; ++j) {
                    ways *= (n - j + m - i - 1);
                    ways /= (j + 1);
                }
                if (k <= ways) {
                    res += 'L';
                } else {
                    res += 'R';
                    k -= ways;
                }
            }
        }
        return res;
    }
};
#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> recoverArray(int n, vector<int>& sums) {
        sort(sums.begin(), sums.end());
        vector<int> res;
        while (n--) {
            unordered_map<int, int> freq;
            int d = sums[1] - sums[0];
            bool hasZero = false;
            vector<int> a, b;
            for (int num : sums) {
                if (freq[num] > 0) {
                    freq[num]--;
                    b.push_back(num);
                } else {
                    if (num == 0) hasZero = true;
                    freq[num + d]++;
                    a.push_back(num);
                }
            }
            if (hasZero) {
                res.push_back(d);
                sums = a;
            } else {
                res.push_back(-d);
                sums = b;
            }
        }
        return res;
    }
};
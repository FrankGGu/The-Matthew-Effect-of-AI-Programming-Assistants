#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>
using namespace std;

class Solution {
public:
    int countKSubsequencesWithMaxBeauty(string s, int k) {
        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }
        if (freq.size() < k) {
            return 0;
        }
        vector<int> counts;
        for (auto& p : freq) {
            counts.push_back(p.second);
        }
        sort(counts.begin(), counts.end(), greater<int>());
        long long res = 1;
        int mod = 1e9 + 7;
        int last = counts[k-1];
        int m = 0;
        int total = 0;
        for (int cnt : counts) {
            if (cnt == last) {
                m++;
            }
            if (cnt > last) {
                total++;
            }
        }
        int choose = k - total;
        for (int i = 0; i < total; ++i) {
            res = (res * counts[i]) % mod;
        }
        long long comb = 1;
        for (int i = 1; i <= choose; ++i) {
            comb = comb * (m - choose + i) / i;
        }
        res = (res * comb) % mod;
        for (int i = 0; i < choose; ++i) {
            res = (res * last) % mod;
        }
        return res;
    }
};
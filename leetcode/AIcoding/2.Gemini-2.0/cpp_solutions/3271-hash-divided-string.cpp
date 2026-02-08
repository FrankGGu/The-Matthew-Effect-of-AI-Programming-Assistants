#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool canSplit(string s, int k) {
        int n = s.length();
        if (n % k != 0) return false;

        int len = n / k;
        unordered_map<long long, int> counts;
        for (int i = 0; i < n; i += len) {
            string sub = s.substr(i, len);
            long long hashVal = 0;
            for (char c : sub) {
                hashVal = (hashVal * 31 + (c - 'a' + 1)) % 1000000007;
            }
            counts[hashVal]++;
        }

        return counts.size() == 1;
    }
};
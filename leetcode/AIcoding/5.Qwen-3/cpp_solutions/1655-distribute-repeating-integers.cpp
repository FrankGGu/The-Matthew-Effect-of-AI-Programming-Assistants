#include <vector>
#include <map>
#include <set>

using namespace std;

class Solution {
public:
    bool solve(int n, vector<int>& quantities) {
        map<int, int> count;
        for (int q : quantities) {
            count[q]++;
        }

        set<int> keys;
        for (auto& [k, v] : count) {
            keys.insert(k);
        }

        for (int k : keys) {
            if (count[k] > n) return false;
            n -= count[k];
        }

        return true;
    }
};
#include <vector>

using namespace std;

class Solution {
public:
    int findArray(vector<int>& pref) {
        int x = pref[0];
        for (int i = 1; i < pref.size(); ++i) {
            x ^= (pref[i] ^ pref[i - 1]);
        }
        return x;
    }
};
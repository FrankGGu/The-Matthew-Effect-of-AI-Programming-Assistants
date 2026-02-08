#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxGroups(vector<int>& counts) {
        unordered_map<int, int> freq;
        for (int num : counts) {
            freq[num]++;
        }

        vector<int> keys;
        for (auto& pair : freq) {
            keys.push_back(pair.first);
        }
        sort(keys.begin(), keys.end());

        int res = 0;
        while (true) {
            int prev = -1;
            bool found = false;
            for (int key : keys) {
                if (freq[key] > 0 && (prev == -1 || key == prev + 1)) {
                    freq[key]--;
                    prev = key;
                    found = true;
                }
            }
            if (!found) break;
            res++;
        }
        return res;
    }
};
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool canReorderDoubled(vector<int>& arr) {
        unordered_map<int, int> freq;
        for (int num : arr) {
            freq[num]++;
        }

        sort(arr.begin(), arr.end(), [](int a, int b) {
            return abs(a) < abs(b);
        });

        for (int num : arr) {
            if (freq[num] == 0) continue;
            if (freq[2 * num] == 0) return false;
            freq[num]--;
            freq[2 * num]--;
        }

        return true;
    }
};
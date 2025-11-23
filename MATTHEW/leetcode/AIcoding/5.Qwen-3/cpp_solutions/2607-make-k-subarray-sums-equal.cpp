#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int makeKSubarrayEqual(vector<int>& arr, int k) {
        int n = arr.size();
        unordered_map<int, int> freq;
        for (int i = 0; i < k; ++i) {
            freq[arr[i]]++;
        }
        int maxFreq = 0;
        for (const auto& [num, count] : freq) {
            maxFreq = max(maxFreq, count);
        }
        int res = 0;
        for (int i = k; i < n; ++i) {
            freq[arr[i - k]]--;
            if (freq[arr[i - k]] == 0) {
                freq.erase(arr[i - k]);
            }
            freq[arr[i]]++;
            int currentMax = 0;
            for (const auto& [num, count] : freq) {
                currentMax = max(currentMax, count);
            }
            res += (currentMax - maxFreq);
        }
        return res;
    }
};
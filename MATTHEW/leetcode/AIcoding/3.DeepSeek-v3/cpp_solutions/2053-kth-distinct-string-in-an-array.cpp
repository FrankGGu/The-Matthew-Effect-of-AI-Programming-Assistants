#include <vector>
#include <string>
#include <unordered_map>

class Solution {
public:
    string kthDistinct(vector<string>& arr, int k) {
        unordered_map<string, int> freq;
        for (const string& s : arr) {
            freq[s]++;
        }
        int count = 0;
        for (const string& s : arr) {
            if (freq[s] == 1) {
                count++;
                if (count == k) {
                    return s;
                }
            }
        }
        return "";
    }
};
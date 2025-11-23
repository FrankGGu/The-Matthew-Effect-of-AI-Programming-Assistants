#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findLeastNumOfUniqueInts(vector<int>& arr, int k) {
        unordered_map<int, int> freq;
        for (int num : arr) {
            freq[num]++;
        }

        vector<int> counts;
        for (auto& pair : freq) {
            counts.push_back(pair.second);
        }

        sort(counts.begin(), counts.end());

        int unique = counts.size();
        for (int count : counts) {
            if (k >= count) {
                k -= count;
                unique--;
            } else {
                break;
            }
        }

        return unique;
    }
};
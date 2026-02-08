#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool uniqueOccurrences(vector<int>& arr) {
        unordered_map<int, int> counts;
        for (int num : arr) {
            counts[num]++;
        }

        unordered_set<int> occurrences;
        for (auto const& [key, val] : counts) {
            if (occurrences.count(val)) {
                return false;
            }
            occurrences.insert(val);
        }

        return true;
    }
};
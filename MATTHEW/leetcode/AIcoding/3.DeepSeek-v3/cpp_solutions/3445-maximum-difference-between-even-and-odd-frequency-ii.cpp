#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxDiffBetweenFrequencies(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        vector<int> evenFreqs, oddFreqs;
        for (auto& [num, count] : freq) {
            if (count % 2 == 0) {
                evenFreqs.push_back(count);
            } else {
                oddFreqs.push_back(count);
            }
        }

        if (evenFreqs.empty() || oddFreqs.empty()) {
            return 0;
        }

        sort(evenFreqs.begin(), evenFreqs.end());
        sort(oddFreqs.begin(), oddFreqs.end());

        int maxDiff1 = evenFreqs.back() - oddFreqs.front();
        int maxDiff2 = oddFreqs.back() - evenFreqs.front();

        return max(maxDiff1, maxDiff2);
    }
};
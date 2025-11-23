#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    bool areOccurrencesEqual(std::string s) {
        std::vector<int> counts(26, 0);
        for (char c : s) {
            counts[c - 'a']++;
        }

        int first_occurrence_count = 0;
        for (int count : counts) {
            if (count > 0) {
                if (first_occurrence_count == 0) {
                    first_occurrence_count = count;
                } else if (count != first_occurrence_count) {
                    return false;
                }
            }
        }
        return true;
    }
};
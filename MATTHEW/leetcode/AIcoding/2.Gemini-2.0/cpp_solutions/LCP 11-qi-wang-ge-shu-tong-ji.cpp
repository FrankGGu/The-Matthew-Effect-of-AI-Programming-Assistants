#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int expectNumber(vector<int>& scores) {
        unordered_set<int> seen;
        int count = 0;
        for (int score : scores) {
            if (seen.find(score) == seen.end()) {
                seen.insert(score);
                count++;
            }
        }
        return count;
    }
};
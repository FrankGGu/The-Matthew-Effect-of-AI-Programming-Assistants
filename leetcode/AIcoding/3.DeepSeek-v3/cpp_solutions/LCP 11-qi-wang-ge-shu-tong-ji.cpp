#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int expectNumber(vector<int>& scores) {
        unordered_set<int> uniqueScores(scores.begin(), scores.end());
        return uniqueScores.size();
    }
};
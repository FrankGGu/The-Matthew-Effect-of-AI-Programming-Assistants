class Solution {
public:
    int countOccurrences(vector<int>& scores, int target) {
        return count(scores.begin(), scores.end(), target);
    }
};
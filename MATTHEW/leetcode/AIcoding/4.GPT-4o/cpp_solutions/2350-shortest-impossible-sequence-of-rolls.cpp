class Solution {
public:
    int shortestSequence(vector<int>& rolls, int k) {
        unordered_set<int> seen;
        int count = 0;
        for (int roll : rolls) {
            seen.insert(roll);
            if (seen.size() == k) {
                count++;
                seen.clear();
            }
        }
        return count + 1;
    }
};
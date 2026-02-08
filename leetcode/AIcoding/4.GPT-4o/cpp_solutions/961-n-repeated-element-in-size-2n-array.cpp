class Solution {
public:
    int repeatedNTimes(vector<int>& A) {
        unordered_set<int> seen;
        for (int num : A) {
            if (seen.count(num)) return num;
            seen.insert(num);
        }
        return -1; // Just to satisfy the function signature
    }
};
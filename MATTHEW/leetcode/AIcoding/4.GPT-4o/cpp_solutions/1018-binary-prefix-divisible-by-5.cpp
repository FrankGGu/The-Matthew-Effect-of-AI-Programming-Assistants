class Solution {
public:
    vector<bool> prefixesDivBy5(vector<int>& A) {
        vector<bool> result;
        int current = 0;
        for (int num : A) {
            current = ((current << 1) + num) % 5;
            result.push_back(current == 0);
        }
        return result;
    }
};
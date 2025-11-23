class Solution {
public:
    int maximumGroups(vector<int>& grading) {
        int n = grading.size();
        int k = 0;
        while (n >= (k + 1) * (k + 2) / 2) {
            k++;
        }
        return k - 1;
    }
};
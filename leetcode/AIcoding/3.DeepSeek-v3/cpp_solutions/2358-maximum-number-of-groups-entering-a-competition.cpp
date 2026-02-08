class Solution {
public:
    int maximumGroups(vector<int>& grades) {
        int n = grades.size();
        int k = 0;
        while ((k + 1) * (k + 2) / 2 <= n) {
            k++;
        }
        return k;
    }
};
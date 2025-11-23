class Solution {
public:
    int maxGroups(vector<int>& grades) {
        int n = grades.size();
        int sum = 0, group = 0;
        while (sum + group + 1 <= n) {
            group++;
            sum += group;
        }
        return group;
    }
};
class Solution {
public:
    int maximumGroups(vector<int>& grades) {
        int total = 0, group = 0;
        while (total + (group + 1) <= grades.size()) {
            total += ++group;
        }
        return group;
    }
};
class Solution {
public:
    int maxVolunteerAllocation(vector<int>& volunteers, vector<int>& tasks) {
        int n = volunteers.size();
        int m = tasks.size();
        sort(volunteers.begin(), volunteers.end());
        sort(tasks.begin(), tasks.end());

        int i = 0, j = 0, count = 0;
        while (i < n && j < m) {
            if (volunteers[i] >= tasks[j]) {
                count++;
                j++;
            }
            i++;
        }
        return count;
    }
};
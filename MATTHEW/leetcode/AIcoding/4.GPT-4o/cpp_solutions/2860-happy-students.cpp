class Solution {
public:
    int countHappyStudents(vector<int>& students, vector<int>& sandwiches) {
        int count = 0;
        int n = students.size();
        int m = sandwiches.size();

        int cnt0 = count(students.begin(), students.end(), 0);
        int cnt1 = n - cnt0;

        for (int i = 0; i < m; ++i) {
            if (sandwiches[i] == 0) {
                if (cnt0 > 0) {
                    cnt0--;
                } else {
                    break;
                }
            } else {
                if (cnt1 > 0) {
                    cnt1--;
                } else {
                    break;
                }
            }
        }

        return cnt0 + cnt1;
    }
};
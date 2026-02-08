class Solution {
public:
    int countStudents(vector<int>& students, vector<int>& sandwiches) {
        int count = 0;
        int n = students.size();
        int m = sandwiches.size();

        int i = 0, j = 0;
        while (i < n && j < m) {
            if (students[i] == sandwiches[j]) {
                i++;
            } else {
                count++;
            }
            j++;
        }

        return count;
    }
};
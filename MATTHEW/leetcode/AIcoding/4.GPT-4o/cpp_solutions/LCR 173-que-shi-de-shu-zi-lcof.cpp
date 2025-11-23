class Solution {
public:
    vector<string> getStudents(vector<string>& students, vector<int>& scores, int threshold) {
        vector<string> result;
        for (int i = 0; i < students.size(); i++) {
            if (scores[i] >= threshold) {
                result.push_back(students[i]);
            }
        }
        return result;
    }
};
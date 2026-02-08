#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<string> attendance(vector<string>& students, vector<string>& called) {
        unordered_set<string> studentSet(students.begin(), students.end());
        vector<string> presentStudents;
        for (const string& name : called) {
            if (studentSet.count(name)) {
                presentStudents.push_back(name);
            }
        }
        return presentStudents;
    }
};
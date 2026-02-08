#include <vector>
#include <unordered_map>
#include <string>

using namespace std;

vector<string> findStudents(vector<string>& students, vector<int>& grades) {
    unordered_map<string, int> studentGrades;
    vector<string> result;

    for (int i = 0; i < students.size(); ++i) {
        studentGrades[students[i]] = grades[i];
    }

    for (int i = 0; i < students.size(); ++i) {
        if (grades[i] > studentGrades[students[i]]) {
            result.push_back(students[i]);
        }
    }

    return result;
}
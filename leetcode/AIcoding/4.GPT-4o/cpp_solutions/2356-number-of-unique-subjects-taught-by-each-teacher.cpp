#include <vector>
#include <unordered_set>

using namespace std;

vector<int> countUniqueSubjects(vector<vector<int>>& subjects) {
    vector<int> result;
    for (const auto& teacherSubjects : subjects) {
        unordered_set<int> uniqueSubjects(teacherSubjects.begin(), teacherSubjects.end());
        result.push_back(uniqueSubjects.size());
    }
    return result;
}
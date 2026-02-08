#include <vector>

using namespace std;

struct Student {
    int id;
    string name;
    int age;
};

class Solution {
public:
    vector<Student> dropMissingData(vector<Student>& students) {
        vector<Student> result;
        for (auto& student : students) {
            if (student.id != 0 && !student.name.empty() && student.age != 0) {
                result.push_back(student);
            }
        }
        return result;
    }
};
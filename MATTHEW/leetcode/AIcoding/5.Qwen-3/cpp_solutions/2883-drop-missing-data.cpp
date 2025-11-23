#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<vector<string>> dropMissingData(vector<vector<string>>& students) {
        vector<vector<string>> result;
        for (const auto& student : students) {
            if (!student.empty() && student[0] != "") {
                result.push_back(student);
            }
        }
        return result;
    }
};
#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> removeMethodsFromProject(vector<string> files) {
        vector<string> result;
        for (const string& file : files) {
            bool isMethod = false;
            for (size_t i = 0; i < file.length(); ++i) {
                if (file[i] == '(') {
                    isMethod = true;
                    break;
                }
            }
            if (!isMethod) {
                result.push_back(file);
            }
        }
        return result;
    }
};
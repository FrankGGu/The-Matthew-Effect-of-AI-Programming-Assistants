#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> fillMissingData(vector<string> &data) {
        for (int i = 0; i < data.size(); ++i) {
            if (data[i].empty()) {
                data[i] = "unknown";
            }
        }
        return data;
    }
};
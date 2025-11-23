#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> concatenateData(vector<string> &data1, vector<string> &data2) {
        data1.insert(data1.end(), data2.begin(), data2.end());
        return data1;
    }
};
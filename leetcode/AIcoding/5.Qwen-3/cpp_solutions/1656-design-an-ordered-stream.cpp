#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
private:
    vector<string> data;
    int ptr;
public:
    Solution(int n) : data(n), ptr(0) {}

    vector<string> insert(int id, string value) {
        data[id - 1] = value;
        vector<string> result;
        while (ptr < data.size() && data[ptr] != "") {
            result.push_back(data[ptr]);
            ptr++;
        }
        return result;
    }
};
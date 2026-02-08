#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> findTheSequence(int n, vector<string>& words) {
        vector<string> result;
        for (int i = 0; i < n; ++i) {
            result.push_back(words[i].substr(0, 3));
        }
        return result;
    }
};
#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    string crackSafe(int n, int k) {
        string result = string(n, '0');
        unordered_set<string> visited;
        visited.insert(result);
        int total = pow(k, n);

        for (int i = 0; i < total; i++) {
            for (int j = 0; j < k; j++) {
                string next = result.substr(result.length() - n + 1) + to_string(j);
                if (visited.find(next) == visited.end()) {
                    result += to_string(j);
                    visited.insert(next);
                    break;
                }
            }
        }

        return result;
    }
};
#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string getHappyString(int n, int k) {
        vector<string> result;
        string current;

        function<void(int)> backtrack = [&](int pos) {
            if (pos == n) {
                result.push_back(current);
                return;
            }
            for (char c = 'a'; c <= 'c'; ++c) {
                if (pos > 0 && c == current.back()) continue;
                current.push_back(c);
                backtrack(pos + 1);
                current.pop_back();
                if (result.size() >= k) return;
            }
        };

        backtrack(0);
        return result.size() >= k ? result[k - 1] : "";
    }
};
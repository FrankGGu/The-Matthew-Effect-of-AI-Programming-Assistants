#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string removeDuplicates(string s, int k) {
        vector<pair<char, int>> stack;
        for (char c : s) {
            if (!stack.empty() && stack.back().first == c) {
                stack.back().second++;
                if (stack.back().second == k) {
                    stack.pop_back();
                }
            } else {
                stack.push_back({c, 1});
            }
        }
        string result;
        for (auto& p : stack) {
            result.append(p.second, p.first);
        }
        return result;
    }
};
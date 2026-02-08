#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool buddyStrings(string A, string B) {
        if (A.length() != B.length()) {
            return false;
        }
        vector<int> diff;
        for (int i = 0; i < A.length(); ++i) {
            if (A[i] != B[i]) {
                diff.push_back(i);
            }
        }
        if (diff.size() == 2) {
            int i = diff[0], j = diff[1];
            return A[i] == B[j] && A[j] == B[i];
        } else if (diff.size() == 0) {
            unordered_set<char> s;
            for (char c : A) {
                if (s.find(c) != s.end()) {
                    return true;
                }
                s.insert(c);
            }
        }
        return false;
    }
};
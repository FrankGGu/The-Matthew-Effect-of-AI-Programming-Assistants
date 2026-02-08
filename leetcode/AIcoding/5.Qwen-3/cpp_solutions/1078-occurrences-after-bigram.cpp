#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> findOcurrences(string text, string first, string second) {
        vector<string> result;
        int n = text.size();
        int i = 0;
        while (i + 2 < n) {
            if (text[i] == first[0] && i + first.size() <= n && text.substr(i, first.size()) == first) {
                int j = i + first.size();
                if (j + second.size() <= n && text.substr(j, second.size()) == second) {
                    int k = j + second.size();
                    if (k < n) {
                        int end = k;
                        while (end < n && text[end] != ' ') {
                            end++;
                        }
                        result.push_back(text.substr(k, end - k));
                    }
                }
                i += first.size();
            } else {
                i++;
            }
        }
        return result;
    }
};
#include <iostream>
#include <vector>
#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    int lengthLongestPath(string input) {
        stack<int> pathLengths;
        int maxLen = 0;
        int i = 0;
        while (i < input.size()) {
            int level = 0;
            while (i < input.size() && input[i] == '\t') {
                level++;
                i++;
            }
            int len = 0;
            bool isFile = false;
            while (i < input.size() && input[i] != '\n') {
                if (input[i] == '.') {
                    isFile = true;
                }
                len++;
                i++;
            }
            if (isFile) {
                if (!pathLengths.empty()) {
                    maxLen = max(maxLen, pathLengths.top() + len);
                } else {
                    maxLen = max(maxLen, len);
                }
            } else {
                if (!pathLengths.empty()) {
                    pathLengths.push(pathLengths.top() + len + 1);
                } else {
                    pathLengths.push(len);
                }
            }
            i++;
            while (!pathLengths.empty() && pathLengths.size() > level + 1) {
                pathLengths.pop();
            }
        }
        return maxLen;
    }
};
#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int lengthLongestPath(string input) {
        vector<int> levelLength(1, 0);
        int maxLength = 0;
        int currentLength = 0;

        for (int i = 0; i < input.length(); ++i) {
            int level = 0;
            while (i < input.length() && input[i] == '\t') {
                level++;
                i++;
            }

            int length = 0;
            bool isFile = false;
            while (i < input.length() && input[i] != '\n') {
                if (input[i] == '.') {
                    isFile = true;
                }
                length++;
                i++;
            }

            while (levelLength.size() <= level + 1) {
                levelLength.push_back(0);
            }

            if (isFile) {
                maxLength = max(maxLength, levelLength[level] + length);
            } else {
                levelLength[level + 1] = levelLength[level] + length + 1;
            }
        }

        return maxLength;
    }
};
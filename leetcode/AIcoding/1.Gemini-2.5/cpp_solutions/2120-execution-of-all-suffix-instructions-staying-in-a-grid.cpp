#include <vector>
#include <string>

class Solution {
public:
    std::vector<int> executeInstructions(int n, std::vector<int>& startPos, std::string s) {
        std::vector<int> ans;
        int m = s.length();

        for (int i = 0; i < m; ++i) {
            int currentRow = startPos[0];
            int currentCol = startPos[1];
            int count = 0;

            for (int j = i; j < m; ++j) {
                char instruction = s[j];

                if (instruction == 'L') {
                    currentCol--;
                } else if (instruction == 'R') {
                    currentCol++;
                } else if (instruction == 'U') {
                    currentRow--;
                } else if (instruction == 'D') {
                    currentRow++;
                }

                if (currentRow < 0 || currentRow >= n || currentCol < 0 || currentCol >= n) {
                    break;
                }
                count++;
            }
            ans.push_back(count);
        }

        return ans;
    }
};
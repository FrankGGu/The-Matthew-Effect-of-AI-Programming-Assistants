#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> executeInstructions(int n, vector<int>& startPos, string s) {
        vector<int> result;
        for (int i = 0; i < s.length(); ++i) {
            int count = 0;
            int row = startPos[0];
            int col = startPos[1];
            for (int j = i; j < s.length(); ++j) {
                if (s[j] == 'R') {
                    col++;
                } else if (s[j] == 'L') {
                    col--;
                } else if (s[j] == 'U') {
                    row--;
                } else {
                    row++;
                }

                if (row < 0 || row >= n || col < 0 || col >= n) {
                    break;
                }
                count++;
            }
            result.push_back(count);
        }
        return result;
    }
};
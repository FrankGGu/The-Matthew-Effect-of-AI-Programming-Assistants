#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string shiftingLetters(string s, vector<vector<int>>& shifts) {
        int n = s.length();
        vector<long long> diff(n, 0);

        for (auto& shift : shifts) {
            int start = shift[0];
            int end = shift[1];
            int direction = shift[2];

            if (direction == 1) {
                diff[start]++;
                if (end + 1 < n) {
                    diff[end + 1]--;
                }
            } else {
                diff[start]--;
                if (end + 1 < n) {
                    diff[end + 1]++;
                }
            }
        }

        long long currentShift = 0;
        for (int i = 0; i < n; ++i) {
            currentShift += diff[i];
            int shiftAmount = (currentShift % 26 + 26) % 26;
            s[i] = (s[i] - 'a' + shiftAmount) % 26 + 'a';
        }

        return s;
    }
};
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string shiftingLetters(string s, vector<vector<int>>& shifts) {
        int n = s.size();
        vector<long long> diff(n + 1, 0);

        for (auto& shift : shifts) {
            int start = shift[0];
            int end = shift[1];
            int direction = shift[2];

            if (direction == 1) {
                diff[start]++;
                diff[end + 1]--;
            } else {
                diff[start]--;
                diff[end + 1]++;
            }
        }

        long long currentShift = 0;
        for (int i = 0; i < n; ++i) {
            currentShift += diff[i];
            int shiftAmount = currentShift % 26;
            if (shiftAmount < 0) {
                shiftAmount += 26;
            }
            s[i] = (char)(((s[i] - 'a' + shiftAmount) % 26) + 'a');
        }

        return s;
    }
};
#include <vector>

using namespace std;

class Solution {
public:
    int numberOfBeams(vector<string>& bank) {
        int prevDevices = 0;
        int totalBeams = 0;

        for (const string& row : bank) {
            int currentDevices = 0;
            for (char c : row) {
                if (c == '1') {
                    currentDevices++;
                }
            }

            if (currentDevices > 0) {
                totalBeams += prevDevices * currentDevices;
                prevDevices = currentDevices;
            }
        }

        return totalBeams;
    }
};
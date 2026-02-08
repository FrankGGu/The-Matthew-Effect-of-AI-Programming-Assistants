#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> recoverArray(int n, vector<int>& doubled) {
        sort(doubled.begin(), doubled.end());
        unordered_map<int, int> count;
        for (int num : doubled) {
            count[num]++;
        }

        for (int d = 1; d <= 100000; d++) {
            if (count[d] == 0) continue;
            vector<int> original;
            unordered_map<int, int> tempCount = count;
            bool valid = true;

            for (int num : doubled) {
                if (tempCount[num] > 0) {
                    tempCount[num]--;
                    if (tempCount[num] < 0) {
                        valid = false;
                        break;
                    }
                    int originalNum = num - d;
                    if (tempCount[originalNum] > 0) {
                        tempCount[originalNum]--;
                        original.push_back(originalNum);
                    } else {
                        valid = false;
                        break;
                    }
                }
            }

            if (valid) {
                return original;
            }
        }

        return {};
    }
};
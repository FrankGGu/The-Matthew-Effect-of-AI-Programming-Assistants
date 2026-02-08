#include <string>
#include <algorithm>
#include <vector>

using namespace std;

class Solution {
public:
    int getMinSwaps(string num, int k) {
        string originalNum = num;
        for (int i = 0; i < k; ++i) {
            next_permutation(num.begin(), num.end());
        }

        int swaps = 0;
        for (int i = 0; i < originalNum.length(); ++i) {
            if (originalNum[i] != num[i]) {
                for (int j = i + 1; j < originalNum.length(); ++j) {
                    if (originalNum[j] == num[i]) {
                        for (int l = j; l > i; --l) {
                            swap(originalNum[l], originalNum[l - 1]);
                            swaps++;
                        }
                        break;
                    }
                }
            }
        }

        return swaps;
    }
};
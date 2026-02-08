#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxConsecutiveAnswers(string answerKey, int k) {
        int n = answerKey.size();
        int maxLen = 0;
        int left = 0, right = 0;
        int tCount = 0, fCount = 0;

        while (right < n) {
            if (answerKey[right] == 'T') {
                tCount++;
            } else {
                fCount++;
            }

            while (min(tCount, fCount) > k) {
                if (answerKey[left] == 'T') {
                    tCount--;
                } else {
                    fCount--;
                }
                left++;
            }

            maxLen = max(maxLen, right - left + 1);
            right++;
        }

        return maxLen;
    }
};
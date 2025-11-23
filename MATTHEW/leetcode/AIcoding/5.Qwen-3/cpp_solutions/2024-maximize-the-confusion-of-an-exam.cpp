#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int maxConsecutiveAnswers(string answerKey, int k) {
        int left = 0;
        int maxLen = 0;
        int countT = 0;
        int countF = 0;

        for (int right = 0; right < answerKey.length(); right++) {
            if (answerKey[right] == 'T') {
                countT++;
            } else {
                countF++;
            }

            while (countT > k && countF > k) {
                if (answerKey[left] == 'T') {
                    countT--;
                } else {
                    countF--;
                }
                left++;
            }

            maxLen = max(maxLen, right - left + 1);
        }

        return maxLen;
    }
};
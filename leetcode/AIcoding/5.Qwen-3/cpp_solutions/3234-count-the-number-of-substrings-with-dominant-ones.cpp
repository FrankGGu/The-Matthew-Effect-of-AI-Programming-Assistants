#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numberOfSubstringsWithDominantOnes(string s) {
        int n = s.size();
        int count = 0;
        int left = 0;
        int ones = 0;

        for (int right = 0; right < n; ++right) {
            if (s[right] == '1') {
                ones++;
            }

            while (ones > 0 && (right - left + 1) % 2 == 0) {
                if (s[left] == '1') {
                    ones--;
                }
                left++;
            }

            count += left;
        }

        return count;
    }
};
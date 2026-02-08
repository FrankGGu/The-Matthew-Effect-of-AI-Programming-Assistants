#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool halvesAreAlike(string s) {
        int n = s.length();
        int half = n / 2;
        vector<char> vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'};
        int count1 = 0, count2 = 0;

        for (int i = 0; i < half; ++i) {
            for (char c : vowels) {
                if (s[i] == c) {
                    count1++;
                    break;
                }
            }
        }

        for (int i = half; i < n; ++i) {
            for (char c : vowels) {
                if (s[i] == c) {
                    count2++;
                    break;
                }
            }
        }

        return count1 == count2;
    }
};
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int takeCharacters(int n, vector<char>& s, vector<int>& k) {
        vector<int> count(26, 0);
        for (char c : s) {
            count[c - 'A']++;
        }

        for (int i = 0; i < 26; ++i) {
            if (count[i] < k[i]) {
                return -1;
            }
        }

        int left = 0;
        int right = 0;
        vector<int> current(26, 0);

        while (right < n) {
            current[s[right] - 'A']++;
            if (current[s[right] - 'A'] > count[s[right] - 'A'] - k[s[right] - 'A']) {
                break;
            }
            right++;
        }

        int result = right;

        while (right < n) {
            while (left <= right && current[s[left] - 'A'] > count[s[left] - 'A'] - k[s[left] - 'A']) {
                current[s[left] - 'A']--;
                left++;
            }

            result = min(result, right - left + 1);

            right++;
            if (right < n) {
                current[s[right] - 'A']++;
            }
        }

        return result;
    }
};
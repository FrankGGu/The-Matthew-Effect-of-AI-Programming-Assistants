#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int balancedString(string s) {
        int n = s.length();
        unordered_map<char, int> counts;
        for (char c : s) {
            counts[c]++;
        }

        int k = n / 4;
        int left = 0;
        int minLength = n;

        for (int right = 0; right < n; ++right) {
            counts[s[right]]--;

            while (counts['Q'] <= k && counts['W'] <= k && counts['E'] <= k && counts['R'] <= k) {
                minLength = min(minLength, right - left + 1);
                counts[s[left]]++;
                left++;
            }
        }

        return minLength;
    }
};
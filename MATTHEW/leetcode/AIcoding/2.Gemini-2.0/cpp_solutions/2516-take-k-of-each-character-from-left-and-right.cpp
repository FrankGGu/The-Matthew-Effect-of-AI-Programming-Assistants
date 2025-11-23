#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int takeCharacters(string s, int k) {
        int n = s.length();
        vector<int> count(3, 0);
        for (char c : s) {
            count[c - 'a']++;
        }
        if (count[0] < k || count[1] < k || count[2] < k) {
            return -1;
        }

        int left = 0;
        int right = n;
        int ans = n;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            bool possible = false;
            for (int i = 0; i <= mid; ++i) {
                int a = 0, b = 0, c = 0;
                if (i > 0) {
                    for (int j = 0; j < i; ++j) {
                        if (s[j] == 'a') a++;
                        else if (s[j] == 'b') b++;
                        else c++;
                    }
                }

                int rem_a = k - a;
                int rem_b = k - b;
                int rem_c = k - c;

                if (rem_a <= 0 && rem_b <= 0 && rem_c <= 0) {
                    possible = true;
                    break;
                }

                if (rem_a >= 0 && rem_b >= 0 && rem_c >= 0) {
                    int a2 = 0, b2 = 0, c2 = 0;
                    for (int j = n - 1; j >= n - (mid - i); --j) {
                        if (s[j] == 'a') a2++;
                        else if (s[j] == 'b') b2++;
                        else c2++;
                    }
                    if (a2 >= rem_a && b2 >= rem_b && c2 >= rem_c) {
                        possible = true;
                        break;
                    }

                }
            }

            if (possible) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return ans;
    }
};
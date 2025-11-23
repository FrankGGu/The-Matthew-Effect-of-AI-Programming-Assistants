#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> maxNumOfSubstrings(string s) {
        int n = s.length();
        vector<int> left(26, n);
        vector<int> right(26, -1);

        for (int i = 0; i < n; ++i) {
            int c = s[i] - 'a';
            left[c] = min(left[c], i);
            right[c] = max(right[c], i);
        }

        vector<pair<int, int>> intervals;
        for (int i = 0; i < 26; ++i) {
            if (left[i] < right[i]) {
                int l = left[i];
                int r = right[i];
                int j = l;
                while (j <= r) {
                    int c = s[j] - 'a';
                    if (left[c] < l) {
                        l = left[c];
                        j = l;
                        continue;
                    }
                    if (right[c] > r) {
                        r = right[c];
                    }
                    j++;
                }
                intervals.push_back({r, l});
            }
        }

        sort(intervals.begin(), intervals.end());

        vector<string> result;
        int last = -1;
        for (auto& p : intervals) {
            int r = p.first;
            int l = p.second;
            if (l > last) {
                result.push_back(s.substr(l, r - l + 1));
                last = r;
            }
        }

        return result;
    }
};
#include <string>
#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minPartitions(string s) {
        int n = s.length();
        if (n == 0) return 0;

        int min_parts = n;
        for (int i = 1; i <= n; ++i) {
            int parts = 0;
            int start = 0;
            while (start < n) {
                int end = start;
                for (int j = start + 1; j < n; ++j) {
                    string sub = s.substr(start, j - start + 1);
                    unordered_map<char, int> counts;
                    for (char c : sub) {
                        counts[c]++;
                    }

                    if (counts.size() == 0) continue;

                    int freq = counts.begin()->second;
                    bool valid = true;
                    for (auto const& [key, val] : counts) {
                        if (val != freq) {
                            valid = false;
                            break;
                        }
                    }
                    if (valid) {
                        end = j;
                    }
                }
                parts++;
                start = end + 1;
            }
            min_parts = min(min_parts, parts);
        }

        return min_parts;
    }
};
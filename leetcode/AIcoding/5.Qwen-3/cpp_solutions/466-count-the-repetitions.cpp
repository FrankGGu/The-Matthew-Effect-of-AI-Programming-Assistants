#include <iostream>
#include <vector>
#include <string>
#include <map>

using namespace std;

class Solution {
public:
    int countRepetitions(string& s, vector<string>& b, int k) {
        map<string, int> cnt;
        int n = b.size();
        for (int i = 0; i < n; ++i) {
            cnt[b[i]]++;
        }
        int total = 0;
        int len = s.length();
        int i = 0;
        while (i < len) {
            for (int j = 0; j < n; ++j) {
                string t = b[j];
                int m = t.length();
                if (i + m <= len && s.substr(i, m) == t) {
                    i += m;
                    total++;
                    if (total == k) {
                        return 1;
                    }
                }
            }
        }
        return 0;
    }
};
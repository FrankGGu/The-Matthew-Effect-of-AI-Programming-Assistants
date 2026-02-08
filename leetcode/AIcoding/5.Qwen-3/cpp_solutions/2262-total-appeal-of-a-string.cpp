#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int appealSum(string s) {
        int n = s.length();
        vector<int> lastOccurrence(26, -1);
        int total = 0;
        int current = 0;

        for (int i = 0; i < n; ++i) {
            int index = s[i] - 'a';
            if (lastOccurrence[index] != -1) {
                current = current - lastOccurrence[index];
            }
            current += (i - lastOccurrence[index]);
            total += current;
            lastOccurrence[index] = i;
        }

        return total;
    }
};
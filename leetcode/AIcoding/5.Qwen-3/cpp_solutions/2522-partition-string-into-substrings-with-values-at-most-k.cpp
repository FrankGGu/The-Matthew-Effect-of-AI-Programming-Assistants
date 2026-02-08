#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minPartitions(string s, int k) {
        int count = 0;
        int n = s.length();
        for (int i = 0; i < n; ) {
            int j = i;
            while (j < n && stoll(s.substr(i, j - i + 1)) <= k) {
                j++;
            }
            if (i == j) return -1;
            count++;
            i = j;
        }
        return count;
    }
};
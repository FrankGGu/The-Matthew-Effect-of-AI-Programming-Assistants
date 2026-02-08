#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxValueAfterInsertion(string s, int k) {
        string result = s;
        for (int i = 0; i < k; ++i) {
            int n = result.length();
            int maxPos = 0;
            for (int j = 1; j < n; ++j) {
                if (result[j] > result[maxPos]) {
                    maxPos = j;
                }
            }
            result.insert(maxPos + 1, "9");
        }
        return stoi(result);
    }
};
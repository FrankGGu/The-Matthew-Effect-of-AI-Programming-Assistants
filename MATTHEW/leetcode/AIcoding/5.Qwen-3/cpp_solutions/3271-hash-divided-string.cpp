#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> splitString(string s, int k) {
        vector<string> result;
        int n = s.length();
        int partSize = n / k;
        int remainder = n % k;
        int start = 0;
        for (int i = 0; i < k; ++i) {
            int currentSize = partSize + (i < remainder ? 1 : 0);
            result.push_back(s.substr(start, currentSize));
            start += currentSize;
        }
        return result;
    }
};
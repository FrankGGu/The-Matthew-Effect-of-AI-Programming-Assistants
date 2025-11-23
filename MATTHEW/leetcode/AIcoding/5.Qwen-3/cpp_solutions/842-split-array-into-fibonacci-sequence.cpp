#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> splitIntoFibonacci(vector<int>& source) {
        vector<int> result;
        for (int i = 1; i < 10 && i < source.size(); ++i) {
            if (source[0] == 0 && i > 1) break;
            long a = 0;
            for (int j = 0; j < i; ++j) {
                a = a * 10 + source[j];
            }
            if (a > INT_MAX) break;
            for (int k = i + 1; k < 10 + i && k < source.size(); ++k) {
                if (source[i] == 0 && k > i + 1) break;
                long b = 0;
                for (int j = i; j < k; ++j) {
                    b = b * 10 + source[j];
                }
                if (b > INT_MAX) break;
                result.push_back(a);
                result.push_back(b);
                int m = k;
                long c = a + b;
                while (m < source.size()) {
                    if (c > INT_MAX) break;
                    if (source[m] != c) {
                        result.clear();
                        break;
                    }
                    ++m;
                    a = b;
                    b = c;
                    c = a + b;
                }
                if (m == source.size()) {
                    return result;
                }
            }
        }
        return result;
    }
};
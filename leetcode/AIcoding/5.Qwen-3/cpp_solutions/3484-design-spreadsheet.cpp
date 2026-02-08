#include <iostream>
#include <vector>
#include <unordered_map>
#include <sstream>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<string> getNames(int n, int k) {
        vector<string> result;
        for (int i = 0; i < n; ++i) {
            string name;
            int num = k + i;
            while (num > 0) {
                int rem = num % 26;
                if (rem == 0) {
                    rem = 26;
                    num /= 26;
                    --num;
                }
                name = char('A' + rem - 1) + name;
                num /= 26;
            }
            result.push_back(name);
        }
        return result;
    }
};
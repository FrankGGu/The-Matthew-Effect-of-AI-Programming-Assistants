#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> addToArrayForm(vector<int>& num, int k) {
        int n = num.size();
        int i = n - 1;
        while (k > 0 && i >= 0) {
            num[i] += k % 10;
            k /= 10;
            i--;
        }
        if (k > 0) {
            vector<int> result;
            while (k > 0) {
                result.push_back(k % 10);
                k /= 10;
            }
            for (int j = result.size() - 1; j >= 0; j--) {
                num.insert(num.begin(), result[j]);
            }
        } else {
            for (int j = i; j >= 0; j--) {
                if (num[j] >= 10) {
                    num[j] %= 10;
                    num[j - 1] += 1;
                }
            }
        }
        return num;
    }
};
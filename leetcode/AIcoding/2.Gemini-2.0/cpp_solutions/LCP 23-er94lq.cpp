#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int magicalString(int n) {
        if (n == 0) return 0;
        if (n <= 3) return 1;

        vector<int> s = {1, 2, 2};
        int head = 2, tail = 3, num = 1, res = 1;

        while (tail < n) {
            for (int i = 0; i < s[head] && tail < n; ++i) {
                s.push_back(num);
                if (num == 1) ++res;
                ++tail;
            }
            num = 3 - num;
            ++head;
        }

        return res;
    }
};
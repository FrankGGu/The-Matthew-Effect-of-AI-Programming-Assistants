#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    Solution() {
        prefix = {1};
    }

    void add(int num) {
        if (num == 0) {
            prefix = {1};
        } else {
            prefix.push_back(prefix.back() * num);
        }
    }

    int product(int k) {
        if (prefix.size() - k < 1) {
            return 0;
        }
        return prefix.back() / prefix[prefix.size() - k];
    }

private:
    vector<int> prefix;
};
#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numberOfChildren(int n, int k) {
        return (k % n == 0) ? n : k % n;
    }
};
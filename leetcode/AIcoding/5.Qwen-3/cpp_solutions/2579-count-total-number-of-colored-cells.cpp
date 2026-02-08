#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    long long countColoredCells(long long p) {
        long long n = p;
        return (n * n) - (n - 1) * (n - 1);
    }
};
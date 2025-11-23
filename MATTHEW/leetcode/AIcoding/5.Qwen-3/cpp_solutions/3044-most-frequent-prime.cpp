#include <iostream>
#include <vector>
#include <unordered_map>
#include <cmath>

using namespace std;

class Solution {
public:
    int mostFrequentPrime(int n, int m, vector<vector<int>>& matrix) {
        unordered_map<int, int> primeCount;
        int maxFreq = 0;
        int result = -1;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                for (int dx = -1; dx <= 1; ++dx) {
                    for (int dy = -1; dy <= 1; ++dy) {
                        if (dx == 0 && dy == 0) continue;
                        int x = i + dx;
                        int y = j + dy;
                        int num = matrix[i][j];
                        while (x >= 0 && x < n && y >= 0 && y < m) {
                            num = num * 10 + matrix[x][y];
                            ++primeCount[num];
                            if (primeCount[num] > maxFreq || (primeCount[num] == maxFreq && num < result)) {
                                maxFreq = primeCount[num];
                                result = num;
                            }
                            x += dx;
                            y += dy;
                        }
                    }
                }
            }
        }

        return result;
    }

private:
    bool isPrime(int num) {
        if (num < 2) return false;
        for (int i = 2; i * i <= num; ++i) {
            if (num % i == 0) return false;
        }
        return true;
    }
};
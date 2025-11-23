#include <vector>
#include <unordered_map>
#include <cmath>

using namespace std;

class Solution {
public:
    int mostFrequentPrime(vector<vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();
        unordered_map<int, int> freq;
        int maxFreq = 0;
        int mostFrequent = -1;

        auto isPrime = [](int num) {
            if (num < 2) return false;
            for (int i = 2; i <= sqrt(num); ++i) {
                if (num % i == 0) return false;
            }
            return true;
        };

        auto explore = [&](int row, int col, int dr, int dc) {
            int num = 0;
            for (int i = row, j = col; i >= 0 && i < m && j >= 0 && j < n; i += dr, j += dc) {
                num = num * 10 + mat[i][j];
                if (num >= 10 && isPrime(num)) {
                    freq[num]++;
                    if (freq[num] > maxFreq) {
                        maxFreq = freq[num];
                        mostFrequent = num;
                    } else if (freq[num] == maxFreq && num > mostFrequent) {
                        mostFrequent = num;
                    }
                }
            }
        };

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                explore(i, j, 0, 1); 
                explore(i, j, 0, -1); 
                explore(i, j, 1, 0); 
                explore(i, j, -1, 0); 
                explore(i, j, 1, 1); 
                explore(i, j, 1, -1); 
                explore(i, j, -1, 1); 
                explore(i, j, -1, -1); 
            }
        }

        return mostFrequent;
    }
};
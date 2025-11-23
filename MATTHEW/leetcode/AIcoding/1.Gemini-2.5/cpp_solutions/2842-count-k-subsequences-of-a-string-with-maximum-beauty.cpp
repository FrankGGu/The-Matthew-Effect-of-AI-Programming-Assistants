#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

const int MOD = 1e9 + 7;

int countKSubsequencesWithMaxBeauty(string s, int k) {
    vector<int> freq(26, 0);
    for (char c : s) {
        freq[c - 'a']++;
    }
    sort(freq.rbegin(), freq.rend());

    int minFreq = 0;
    int count = 0;
    for (int i = 0; i < 26; ++i) {
        if (freq[i] > 0) {
            if (i < k) {
                minFreq = freq[i];
            } else if (freq[i] == minFreq) {
                count++;
            } else {
                break;
            }
        }
    }

    int numMinFreq = 0;
    for (int i = 0; i < 26; ++i) {
        if (freq[i] == minFreq) {
            numMinFreq++;
        }
    }

    long long n = numMinFreq;
    long long r = 0;
    for(int i = 0; i < k; ++i){
        if(freq[i] == minFreq){
            r++;
        }
    }

    if (r == 0) return 1;

    vector<vector<long long>> C(n + 1, vector<long long>(r + 1, 0));
    for (int i = 0; i <= n; ++i) {
        C[i][0] = 1;
        for (int j = 1; j <= min(i, (int)r); ++j) {
            C[i][j] = (C[i - 1][j - 1] + C[i - 1][j]) % MOD;
        }
    }

    return C[n][r];
}
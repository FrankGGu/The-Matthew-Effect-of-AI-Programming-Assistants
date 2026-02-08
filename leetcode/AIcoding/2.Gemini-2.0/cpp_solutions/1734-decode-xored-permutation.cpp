#include <vector>

using namespace std;

class Solution {
public:
    vector<int> decode(vector<int>& encoded, int n) {
        int totalXor = 0;
        for (int i = 1; i <= n; ++i) {
            totalXor ^= i;
        }

        int encodedXor = 0;
        for (int i = 1; i < n - 1; i += 2) {
            encodedXor ^= encoded[i];
        }

        int first = totalXor ^ encodedXor;

        vector<int> perm(n);
        perm[0] = first;
        for (int i = 1; i < n; ++i) {
            perm[i] = perm[i - 1] ^ encoded[i - 1];
        }

        return perm;
    }
};
#include <vector>

using namespace std;

class Solution {
public:
    int reinitializePermutation(int n) {
        vector<int> perm(n);
        vector<int> arr(n);
        for (int i = 0; i < n; ++i) {
            perm[i] = i;
            arr[i] = i;
        }

        int operations = 0;
        do {
            vector<int> nextPerm(n);
            for (int i = 0; i < n; ++i) {
                if (i % 2 == 0) {
                    nextPerm[i] = perm[i / 2];
                } else {
                    nextPerm[i] = perm[n / 2 + (i - 1) / 2];
                }
            }
            perm = nextPerm;
            operations++;
        } while (perm != arr);

        return operations;
    }
};
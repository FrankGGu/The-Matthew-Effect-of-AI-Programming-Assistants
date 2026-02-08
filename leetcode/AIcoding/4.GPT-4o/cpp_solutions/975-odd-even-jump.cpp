class Solution {
public:
    bool oddEvenJumps(vector<int>& A) {
        int n = A.size();
        vector<bool> oddJump(n, false), evenJump(n, false);
        oddJump[n - 1] = evenJump[n - 1] = true;

        map<int, int> indexMap;
        indexMap[A[n - 1]] = n - 1;

        for (int i = n - 2; i >= 0; --i) {
            auto it = indexMap.lower_bound(A[i]);
            if (it != indexMap.end() && evenJump[it->second]) {
                oddJump[i] = true;
            }
            it = indexMap.upper_bound(A[i]);
            if (it != indexMap.begin()) {
                --it;
                if (oddJump[it->second]) {
                    evenJump[i] = true;
                }
            }
            indexMap[A[i]] = i;
        }

        return oddJump[0];
    }
};
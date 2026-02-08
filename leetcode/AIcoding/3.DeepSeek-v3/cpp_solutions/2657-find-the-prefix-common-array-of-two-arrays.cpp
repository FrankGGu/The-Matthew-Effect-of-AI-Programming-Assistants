class Solution {
public:
    vector<int> findThePrefixCommonArray(vector<int>& A, vector<int>& B) {
        int n = A.size();
        vector<int> res(n, 0);
        unordered_set<int> setA, setB;

        for (int i = 0; i < n; ++i) {
            setA.insert(A[i]);
            setB.insert(B[i]);
            int count = 0;
            for (int num : setA) {
                if (setB.count(num)) {
                    count++;
                }
            }
            res[i] = count;
        }

        return res;
    }
};
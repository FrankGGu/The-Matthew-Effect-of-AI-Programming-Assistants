#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> common = {};
    vector<int> findThePrefixCommonArray(vector<int>& A, vector<int>& B) {
        vector<int> result;
        unordered_set<int> setA;
        unordered_set<int> setB;
        for (int i = 0; i < A.size(); ++i) {
            setA.insert(A[i]);
            setB.insert(B[i]);
            int count = 0;
            for (int num : setA) {
                if (setB.find(num) != setB.end()) {
                    ++count;
                }
            }
            result.push_back(count);
        }
        return result;
    }
};
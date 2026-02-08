class Solution {
public:
    long long minCost(vector<int>& A, vector<int>& B) {
        unordered_map<int, long long> countA, countB;
        for (int a : A) countA[a]++;
        for (int b : B) countB[b]++;

        long long cost = 0;
        for (auto& [key, val] : countA) {
            if (countB.count(key)) {
                cost += abs(countA[key] - countB[key]) * key;
            } else {
                cost += countA[key] * key;
            }
        }

        for (auto& [key, val] : countB) {
            if (!countA.count(key)) {
                cost += countB[key] * key;
            }
        }

        return cost;
    }
};
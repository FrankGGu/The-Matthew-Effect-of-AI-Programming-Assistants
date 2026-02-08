class Solution {
public:
    vector<int> sumEvenAfterQueries(vector<int>& A, vector<vector<int>>& queries) {
        int evenSum = 0;
        for (int num : A) {
            if (num % 2 == 0) evenSum += num;
        }

        vector<int> result;
        for (const auto& query : queries) {
            int value = query[0], index = query[1];
            if (A[index] % 2 == 0) evenSum -= A[index];
            A[index] += value;
            if (A[index] % 2 == 0) evenSum += A[index];
            result.push_back(evenSum);
        }

        return result;
    }
};
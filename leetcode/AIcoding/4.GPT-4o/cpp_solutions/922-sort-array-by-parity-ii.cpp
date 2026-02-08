class Solution {
public:
    vector<int> sortArrayByParityII(vector<int>& A) {
        vector<int> result(A.size());
        int evenIndex = 0, oddIndex = 1;

        for (int num : A) {
            if (num % 2 == 0) {
                result[evenIndex] = num;
                evenIndex += 2;
            } else {
                result[oddIndex] = num;
                oddIndex += 2;
            }
        }

        return result;
    }
};
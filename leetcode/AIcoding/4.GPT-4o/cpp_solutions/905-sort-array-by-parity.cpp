class Solution {
public:
    vector<int> sortArrayByParity(vector<int>& A) {
        vector<int> result;
        for (int num : A) {
            if (num % 2 == 0) {
                result.push_back(num);
            }
        }
        for (int num : A) {
            if (num % 2 != 0) {
                result.push_back(num);
            }
        }
        return result;
    }
};
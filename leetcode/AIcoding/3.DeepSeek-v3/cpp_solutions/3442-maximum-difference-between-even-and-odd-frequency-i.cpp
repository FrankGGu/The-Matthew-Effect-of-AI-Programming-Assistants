class Solution {
public:
    int maxDiffBetweenEvenAndOddFrequency(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }
        int maxEven = -1;
        int minOdd = -1;
        for (auto& [num, count] : freq) {
            if (count % 2 == 0) {
                if (maxEven == -1 || count > maxEven) {
                    maxEven = count;
                }
            } else {
                if (minOdd == -1 || count < minOdd) {
                    minOdd = count;
                }
            }
        }
        if (maxEven == -1 || minOdd == -1) {
            return 0;
        }
        return maxEven - minOdd;
    }
};
class Solution {
public:
    int maxEqualFreq(vector<int>& nums) {
        unordered_map<int, int> count;
        unordered_map<int, int> freq;
        int maxFreq = 0;
        int uniqueCounts = 0;

        for (int num : nums) {
            if (count[num] > 0) {
                freq[count[num]]--;
                if (freq[count[num]] == 0) {
                    freq.erase(count[num]);
                    uniqueCounts--;
                }
            }
            count[num]++;
            freq[count[num]]++;
            if (freq[count[num]] == 1) {
                uniqueCounts++;
            }
            maxFreq = max(maxFreq, count[num]);
        }

        int result = 0;
        for (int i = 1; i <= maxFreq; i++) {
            if (freq.count(i) == 0) continue;
            if (freq.size() == 1) {
                if (freq.begin()->first == 1 || freq.begin()->second == 1) {
                    result = max(result, freq.begin()->second);
                }
            } else if (freq.size() == 2) {
                auto it = freq.begin();
                int firstCount = it->first, firstFreq = it->second;
                it++;
                int secondCount = it->first, secondFreq = it->second;
                if ((firstCount == 1 && firstFreq == 1) || (secondCount == 1 && secondFreq == 1) || 
                    (firstCount - secondCount == 1 && firstFreq == 1) || 
                    (secondCount - firstCount == 1 && secondFreq == 1)) {
                    result = max(result, firstFreq + secondFreq);
                }
            }
        }
        return result;
    }
};
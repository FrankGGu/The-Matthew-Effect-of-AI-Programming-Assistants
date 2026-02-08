using namespace std;

class Solution {
public:
    int maxFrequencyElements(vector<int>& nums) {
        unordered_map<int, int> freqMap;
        for (int num : nums) {
            freqMap[num]++;
        }

        int maxFreq = 0;
        for (const auto& kv : freqMap) {
            if (kv.second > maxFreq) {
                maxFreq = kv.second;
            }
        }

        int count = 0;
        for (const auto& kv : freqMap) {
            if (kv.second == maxFreq) {
                count += kv.second;
            }
        }

        return count;
    }
};
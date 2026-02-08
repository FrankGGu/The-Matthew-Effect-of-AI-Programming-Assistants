class Solution {
public:
    int sumOfImbalanceNumbers(vector<int>& nums) {
        int n = nums.size();
        long long totalImbalance = 0;
        for (int i = 0; i < n; i++) {
            map<int, int> count;
            for (int j = i; j < n; j++) {
                count[nums[j]]++;
                int imbalance = 0;
                for (auto it = count.begin(); it != count.end(); ++it) {
                    if (it != count.begin() && it != prev(count.end())) {
                        imbalance += (it->first - prev(it)->first) * (it->second);
                    }
                }
                totalImbalance += imbalance;
            }
        }
        return totalImbalance;
    }
};
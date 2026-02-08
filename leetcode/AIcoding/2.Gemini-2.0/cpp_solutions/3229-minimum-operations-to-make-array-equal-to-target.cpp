#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int target) {
        long long sum = accumulate(nums.begin(), nums.end(), 0LL);
        if (sum < target) return -1;

        vector<int> bits;
        for (int num : nums) {
            int power = 0;
            while (num > 0) {
                if (num % 2 == 1) bits.push_back(power);
                num /= 2;
                power++;
            }
        }
        sort(bits.begin(), bits.end());

        int operations = 0;
        int current_power = 0;
        while (target > 0) {
            if (target % 2 == 1) {
                auto it = lower_bound(bits.begin(), bits.end(), current_power);
                if (it == bits.end() || *it != current_power) {
                    int next_power = -1;
                    for (int bit : bits) {
                        if (bit > current_power) {
                            next_power = bit;
                            break;
                        }
                    }
                    if (next_power == -1) return -1;

                    auto it2 = lower_bound(bits.begin(), bits.end(), next_power);
                    bits.erase(it2);
                    operations += (next_power - current_power);
                    for (int i = 0; i < next_power - current_power; ++i) {
                        bits.push_back(current_power + i);
                    }
                    sort(bits.begin(), bits.end());
                } else {
                    bits.erase(it);
                }
            }
            target /= 2;
            current_power++;
        }

        return operations;
    }
};
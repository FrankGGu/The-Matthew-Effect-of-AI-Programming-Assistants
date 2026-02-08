#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxStrength(vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }

        sort(nums.begin(), nums.end());

        long long product = 1;
        int negativeCount = 0;
        bool hasZero = false;

        for (int num : nums) {
            if (num < 0) {
                negativeCount++;
            } else if (num == 0) {
                hasZero = true;
            }
        }

        if (nums.size() == 1) {
            return nums[0];
        }

        if (negativeCount % 2 == 0) {
            bool allNegative = true;
            for(int num : nums){
                if(num >= 0){
                    allNegative = false;
                    break;
                }
            }
            if(allNegative && hasZero){
                return 0;
            }
            int firstZeroIndex = -1;
            for(int i = 0; i < nums.size(); ++i){
                if(nums[i] == 0){
                    firstZeroIndex = i;
                    break;
                }
            }
            if(allNegative && firstZeroIndex != -1){
                return 0;
            }

            for (int num : nums) {
                if (num != 0) {
                    product *= num;
                }
            }
            if(product == 1 && negativeCount > 0){

                int smallestNegative = -101;
                for(int num : nums){
                    if(num < 0){
                        smallestNegative = max(smallestNegative, num);
                    }
                }

                if(smallestNegative != -101 && negativeCount > 0){
                    product = 1;
                    bool skipped = false;
                    for(int num : nums){
                        if(num == smallestNegative && !skipped){
                            skipped = true;
                            continue;
                        }
                        if(num != 0){
                            product *= num;
                        }
                    }

                }
            }

        } else {
            if(negativeCount == 1 && nums.size() == 1){
                return nums[0];
            }

            if (negativeCount == (int)nums.size() && nums.back() < 0 && nums.size() == 1)
                return nums[0];

            bool allNegative = true;
            for(int num : nums){
                if(num >= 0){
                    allNegative = false;
                    break;
                }
            }
            if(allNegative && hasZero){
                return 0;
            }
            int firstZeroIndex = -1;
            for(int i = 0; i < nums.size(); ++i){
                if(nums[i] == 0){
                    firstZeroIndex = i;
                    break;
                }
            }
            if(allNegative && firstZeroIndex != -1){
                return 0;
            }
            int largestNegative = 101;

            for(int num : nums){
                if(num < 0){
                    largestNegative = min(largestNegative, num);
                }
            }

            bool skipped = false;
            for(int num : nums){
                if(num == largestNegative && !skipped){
                    skipped = true;
                    continue;
                }
                if(num != 0){
                    product *= num;
                }
            }
        }

        if(product == 1 && hasZero){
            return 0;
        }

        return product;
    }
};
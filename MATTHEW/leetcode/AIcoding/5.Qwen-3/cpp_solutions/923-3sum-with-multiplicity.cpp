#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int threeSumMulti(int* arr, int arrSize, int target) {
        sort(arr, arr + arrSize);
        long long count = 0;
        for (int i = 0; i < arrSize - 2; ++i) {
            int left = i + 1;
            int right = arrSize - 1;
            while (left < right) {
                int sum = arr[i] + arr[left] + arr[right];
                if (sum == target) {
                    if (arr[left] == arr[right]) {
                        long long n = right - left + 1;
                        count += n * (n - 1) / 2;
                        break;
                    } else {
                        int leftCount = 1;
                        while (left < right && arr[left] == arr[left + 1]) {
                            left++;
                            leftCount++;
                        }
                        int rightCount = 1;
                        while (left < right && arr[right] == arr[right - 1]) {
                            right--;
                            rightCount++;
                        }
                        count += leftCount * rightCount;
                    }
                    left++;
                    right--;
                } else if (sum < target) {
                    left++;
                } else {
                    right--;
                }
            }
        }
        return count;
    }
};
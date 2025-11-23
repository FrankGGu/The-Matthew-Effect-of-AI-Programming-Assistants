#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int longestCommonPrefix(vector<int>& arr) {
        if (arr.empty()) return 0;
        int minVal = arr[0];
        for (int num : arr) {
            if (num < minVal) {
                minVal = num;
            }
        }
        int count = 0;
        while (minVal > 0) {
            bool allHave = true;
            for (int num : arr) {
                if (num % 10 != minVal % 10) {
                    allHave = false;
                    break;
                }
            }
            if (!allHave) break;
            count++;
            minVal /= 10;
        }
        return count;
    }
};
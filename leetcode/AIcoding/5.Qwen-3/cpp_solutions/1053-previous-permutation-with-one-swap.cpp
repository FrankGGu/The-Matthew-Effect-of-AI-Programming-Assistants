#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> prevPermuationWithOneSwap(vector<int>& arr) {
        int n = arr.size();
        int i = n - 2;
        while (i >= 0 && arr[i] <= arr[i + 1]) {
            i--;
        }
        if (i < 0) {
            return vector<int>();
        }
        int j = n - 1;
        while (arr[j] >= arr[i]) {
            j--;
        }
        swap(arr[i], arr[j]);
        return arr;
    }
};
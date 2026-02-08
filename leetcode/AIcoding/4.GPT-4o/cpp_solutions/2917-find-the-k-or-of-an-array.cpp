class Solution {
public:
    int findKth(int arr[], int n, int k) {
        sort(arr, arr + n);
        return arr[k - 1];
    }
};
class Solution {
public:
    int minChoco(int arr[], int n) {
        int totalChoco = 0;
        for (int i = 0; i < n; i++) {
            totalChoco += arr[i];
        }
        return totalChoco - n; // The maximum possible chocolates to collect is total - n
    }
};
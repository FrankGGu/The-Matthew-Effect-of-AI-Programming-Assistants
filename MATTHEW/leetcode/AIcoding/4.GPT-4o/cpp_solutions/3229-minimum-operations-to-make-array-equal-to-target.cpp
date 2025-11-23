class Solution {
public:
    int minOperations(int n, int target) {
        int mid = n / 2;
        int total = mid * mid + mid;
        if (n % 2 == 0) total -= mid; 
        return abs(total - target);
    }
};
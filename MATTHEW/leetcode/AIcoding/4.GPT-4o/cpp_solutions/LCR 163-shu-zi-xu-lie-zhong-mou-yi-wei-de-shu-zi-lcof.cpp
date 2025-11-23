class Solution {
public:
    int findKthDigit(int n, int k) {
        long long count = 9, len = 1, start = 1;

        while (k > len * count) {
            k -= len * count;
            len++;
            count *= 10;
            start *= 10;
        }

        start += (k - 1) / len;
        string num = to_string(start);
        return num[(k - 1) % len] - '0';
    }
};
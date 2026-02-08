class Solution {
public:
    int preimageSize(int k) {
        long long high = findKth(k);
        long long low = findKth(k - 1);
        return high - low;
    }

    long long findKth(int k) {
        long long low = 0, high = 5LL * (k + 1);
        while (low <= high) {
            long long mid = low + (high - low) / 2;
            long long count = countFive(mid);
            if (count < k + 1) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return low;
    }

    long long countFive(long long x) {
        long long count = 0;
        while (x > 0) {
            count += x / 5;
            x /= 5;
        }
        return count;
    }
};
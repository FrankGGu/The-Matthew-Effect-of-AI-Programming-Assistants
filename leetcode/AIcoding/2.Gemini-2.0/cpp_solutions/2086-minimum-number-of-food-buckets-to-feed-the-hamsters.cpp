class Solution {
public:
    int minimumBuckets(string street) {
        int n = street.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (street[i] == 'H') {
                if (i > 0 && street[i - 1] == 'B') continue;
                if (i < n - 1 && street[i + 1] == '.') {
                    count++;
                    street[i + 1] = 'B';
                } else if (i > 0 && street[i - 1] == '.') {
                    count++;
                    street[i - 1] = 'B';
                } else {
                    return -1;
                }
            }
        }
        return count;
    }
};
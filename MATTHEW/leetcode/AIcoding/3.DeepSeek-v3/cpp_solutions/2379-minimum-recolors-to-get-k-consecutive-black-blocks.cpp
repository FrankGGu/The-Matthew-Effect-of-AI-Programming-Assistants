class Solution {
public:
    int minimumRecolors(string blocks, int k) {
        int min_operations = INT_MAX;
        int white_count = 0;

        for (int i = 0; i < blocks.size(); ++i) {
            if (blocks[i] == 'W') {
                white_count++;
            }

            if (i >= k - 1) {
                if (i >= k) {
                    if (blocks[i - k] == 'W') {
                        white_count--;
                    }
                }
                min_operations = min(min_operations, white_count);
            }
        }

        return min_operations;
    }
};
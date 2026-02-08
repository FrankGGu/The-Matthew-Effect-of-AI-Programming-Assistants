class Solution {
public:
    int minimumPartition(std::string s, int k) {
        int partitions = 0;
        long long current_num = 0;
        int n = s.length();

        for (int i = 0; i < n; ++i) {
            int digit = s[i] - '0';

            // If the current digit itself is greater than k, it's impossible to form a valid partition.
            // The problem statement guarantees a solution exists, so this case shouldn't happen
            // given that k >= 1 and s[i] is a digit.
            // However, if k is 0, and s[i] is '1', this would be true. But k >= 1.
            // So, digit <= k is always true.

            // Try to extend the current number
            long long next_num = current_num * 10 + digit;

            if (next_num > k) {
                // The current digit cannot be appended to the current_num.
                // This means the current substring ends before s[i].
                // Start a new partition with s[i].
                partitions++;
                current_num = digit; // The new partition starts with this digit
            } else {
                // The current digit can be appended.
                current_num = next_num;
            }
        }

        // Add the last partition if the string was not empty
        if (n > 0) {
            partitions++;
        }

        return partitions;
    }
};
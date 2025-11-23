#include <vector>

class Solution {
public:
    int magicalString(int n) {
        if (n <= 0) {
            return 0;
        }
        if (n <= 3) {
            return 1;
        }

        std::vector<int> s;
        s.reserve(n + 2); // Pre-allocate memory to avoid reallocations
        s.push_back(1);
        s.push_back(2);
        s.push_back(2);

        int head = 2; // Pointer to the current length in s
        int current_num_to_append = 1; // The number to append (1 or 2)
        int ones_count = 1; // S[0] is '1'

        while (s.size() < n) {
            int count = s[head]; // Get the length from the magical string itself
            for (int i = 0; i < count; ++i) {
                s.push_back(current_num_to_append);
                if (current_num_to_append == 1) {
                    ones_count++;
                }
                if (s.size() == n) {
                    break; // Stop if we have generated N elements
                }
            }
            current_num_to_append = 3 - current_num_to_append; // Toggle 1 to 2, 2 to 1
            head++;
        }

        return ones_count;
    }
};
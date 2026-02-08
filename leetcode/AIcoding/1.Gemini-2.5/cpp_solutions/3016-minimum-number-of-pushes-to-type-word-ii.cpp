#include <string>
#include <vector>
#include <algorithm>
#include <functional>

class Solution {
public:
    int minimumPushes(std::string word) {
        std::vector<int> freq(26, 0);
        for (char c : word) {
            freq[c - 'a']++;
        }

        std::sort(freq.begin(), freq.end(), std::greater<int>());

        int totalPushes = 0;
        for (int i = 0; i < 26; ++i) {
            if (freq[i] == 0) {
                break;
            }

            // The i-th character (0-indexed) in the sorted frequency list
            // will be assigned to a key slot.
            // There are 9 keys, and each key offers 8 slots (1-push, 2-push, ..., 8-push).
            // This means there are 9 slots that require 1 push,
            // 9 slots that require 2 pushes, and so on.
            //
            // For the first 9 characters (i=0 to 8), they get 1 push each.
            // For the next 9 characters (i=9 to 17), they get 2 pushes each.
            // For the next 9 characters (i=18 to 26), they get 3 pushes each.
            // And so on.
            // The number of pushes required for the character at index `i` is `(i / 9) + 1`.
            int pushes = (i / 9) + 1;
            totalPushes += freq[i] * pushes;
        }

        return totalPushes;
    }
};
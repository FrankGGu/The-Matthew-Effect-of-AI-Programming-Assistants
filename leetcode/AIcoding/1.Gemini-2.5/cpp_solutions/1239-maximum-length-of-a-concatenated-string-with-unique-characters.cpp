#include <vector>
#include <string>
#include <algorithm> // For std::max

class Solution {
public:
    int maxLength(std::vector<std::string>& arr) {
        std::vector<int> dp; // Stores valid masks found so far
        dp.push_back(0); // Represents an empty string with 0 length and no characters

        int max_len = 0;

        for (const std::string& s : arr) {
            int char_mask = 0;
            bool is_unique_in_s = true;

            // Calculate mask for current string s and check for unique characters within s
            for (char c : s) {
                int bit = 1 << (c - 'a');
                if ((char_mask & bit) != 0) { // Character already seen in s
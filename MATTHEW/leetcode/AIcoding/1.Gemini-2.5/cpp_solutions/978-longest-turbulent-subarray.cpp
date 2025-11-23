#include <vector>
#include <algorithm> // Required for std::max

class Solution {
public:
    int longestTurbulentSubarray(std::vector<int>& arr) {
        int n = arr.size();
        if (n <= 1) {
            return n;
        }

        int max_len = 1;
        // inc: length of turbulent subarray ending at current position 'i'
        //      where the last comparison was arr[i-1] < arr[i]
        int inc = 1;
        // dec: length of turbulent subarray ending at current position 'i'
        //      where the last comparison was arr[i-1] > arr[i]
        int dec = 1;

        for (int i = 1; i < n; ++i) {
            if (arr[i] > arr[i-1]) {
                // Current comparison is increasing (arr[i-1] < arr[i])
                // To maintain turbulence, the previous comparison must have been decreasing.
                // So, we extend the 'dec' sequence from the previous step.
                inc = dec + 1;
                // A sequence ending with a decreasing comparison cannot be extended with an increasing one.
                // It restarts with length 1 if it were to start a new decreasing sequence.
                // But 'dec' represents a sequence ending with arr[i-1] > arr[i], which is not the case here.
                // So, 'dec' for the current 'i' resets to 1.
                dec = 1;
            } else if (arr[i] < arr[i-1]) {
                // Current comparison is decreasing (arr[i-1] > arr[i])
                // To maintain turbulence, the previous comparison must have been increasing.
                // So, we extend the 'inc' sequence from the previous step.
                dec = inc + 1;
                // 'inc' for the current 'i' resets to 1.
                inc = 1;
            } else { // arr[i] == arr[i-1]
                // The turbulence is broken, as elements must be strictly alternating.
                // Both increasing and decreasing sequences restart with length 1.
                inc = 1;
                dec = 1;
            }
            // Update the maximum length found so far.
            // std::max({a, b, c}) requires C++11 and an initializer list.
            max_len = std::max({max_len, inc, dec});
        }

        return max_len;
    }
};
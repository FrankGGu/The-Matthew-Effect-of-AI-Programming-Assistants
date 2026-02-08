#include <string>
#include <vector>
#include <cctype> // For isdigit

class Solution {
public:
    std::string decodeAtIndex(std::string S, int K) {
        long long decoded_length = 0;

        // First pass: Calculate the total length of the decoded string
        for (char c : S) {
            if (isdigit(c)) {
                decoded_length *= (c - '0');
            } else {
                decoded_length++;
            }
        }

        // Second pass: Iterate backwards through S to find the K-th character
        for (int i = S.length() - 1; i >= 0; --i) {
            char c = S[i];

            // Adjust K based on the current segment's length.
            // K is 1-indexed. If K becomes 0 after modulo, it means the target character
            // is the last one in the current segment, so we effectively set K to decoded_length.
            K %= decoded_length;
            if (K == 0) {
                K = decoded_length;
            }

            if (isdigit(c)) {
                // If it's a digit, it means the current segment was formed by repeating a shorter segment.
                // We divide the current length by the digit to get the length of the previous segment.
                decoded_length /= (c - '0');
            } else { // It's a letter
                // If K matches the current length, then this character is our answer.
                // This is because we are working backwards. If K is exactly the length
                // of the string up to this point, and this is a letter, it must be the Kth character.
                if (K == decoded_length) {
                    return std::string(1, c);
                }
                // If it's a letter and not the target, we decrement the length
                // as we move to the previous character in the original string S.
                decoded_length--;
            }
        }

        // This line should theoretically not be reached as K is guaranteed to be valid.
        return ""; 
    }
};
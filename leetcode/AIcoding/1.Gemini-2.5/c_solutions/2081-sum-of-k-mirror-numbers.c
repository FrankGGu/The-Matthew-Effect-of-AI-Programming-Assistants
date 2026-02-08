#include <stdbool.h>
#include <limits.h> // For LLONG_MAX

static long long reverse_num(long long n) {
    long long reversed = 0;
    while (n > 0) {
        reversed = reversed * 10 + (n % 10);
        n /= 10;
    }
    return reversed;
}

static long long generate_base10_palindrome(long long half, bool is_odd_length) {
    long long p = half;
    // For odd length, the middle digit is the last digit of 'half', so we reverse 'half / 10'.
    // For even length, there's no middle digit, so we reverse 'half'.
    long long temp_half = is_odd_length ? half / 10 : half;

    while (temp_half > 0) {
        // Check for overflow before multiplication by 10
        if (p > LLONG_MAX / 10) return LLONG_MAX;
        p *= 10;

        // Check for overflow before addition of the digit
        if (p > LLONG_MAX - (temp_half % 10)) return LLONG_MAX;
        p += (temp_half % 10);

        temp_half /= 10;
    }
    return p;
}

static bool is_palindrome_base_k(long long num, int k) {
    if (num == 0) return true; // Although problem states positive integer, 0 is technically a palindrome.

    // Store base k digits in an array.
    // A long long can have at most 64 digits in base 2 (log2(LLONG_MAX) is approximately 63).
    // For other bases (k > 2), the number of digits will be less than 64.
    int digits[64]; 
    int count = 0;
    long long temp_num = num;

    while (temp_num > 0) {
        digits[count++] = temp_num % k;
        temp_num /= k;
    }

    // Check if the digits array forms a palindrome.
    for (int i = 0; i < count / 2; i++) {
        if (digits[i] != digits[count - 1 - i]) {
            return false;
        }
    }
    return true;
}

long long sum_k_mirror_numbers(int n, int k) {
    long long sum = 0;
    int found_count = 0;

    // `half_odd` and `half_even` are the left halves used to generate base-10 palindromes.
    // They start from 1 to generate smallest positive palindromes.
    long long half_odd = 1;
    long long half_even = 1;

    // Generate the initial candidates for odd and even length palindromes.
    long long p_odd = generate_base10_palindrome(half_odd, true);
    long long p_even = generate_base10_palindrome(half_even, false);

    // Loop until we find 'n' k-mirror numbers.
    while (found_count < n) {
        long long current_palindrome;
        bool is_odd_type; // True if current_palindrome came from p_odd, False if from p_even.

        // Select the smaller of the two current palindrome candidates.
        // If p_odd and p_even are equal, prioritize p_odd (arbitrary, but consistent).
        if (p_odd <= p_even) {
            current_palindrome = p_odd;
            is_odd_type = true;
        } else {
            current_palindrome = p_even;
            is_odd_type = false;
        }

        // If the current_palindrome is LLONG_MAX, it means all representable long long palindromes
        // have been exhausted from this stream (due to overflow or reaching max half value).
        // For the given constraints (n up to 30), the Nth k-mirror number is small enough
        // to fit in long long, so this condition should not be met.
        if (current_palindrome == LLONG_MAX) {
            break; 
        }

        // Check if the selected palindrome is a k-mirror number.
        // Palindromes generated from `half >= 1` are positive.
        if (is_palindrome_base_k(current_palindrome, k)) {
            sum += current_palindrome;
            found_count++;
        }

        // Generate the next palindrome candidate for the stream that was just used.
        if (is_odd_type) {
            half_odd++;
            p_odd = generate_base10_palindrome(half_odd, true);
        } else {
            half_even++;
            p_even = generate_base10_palindrome(half_even, false);
        }
    }

    return sum;
}
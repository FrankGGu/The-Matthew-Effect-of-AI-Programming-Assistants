var superpalindromesInRange = function(L, R) {
    const L_big = BigInt(L);
    const R_big = BigInt(R);
    let count = 0;

    const isPalindrome = (s) => {
        let left = 0;
        let right = s.length - 1;
        while (left < right) {
            if (s[left] !== s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    };

    // Iterate 'i' to generate the first half of the palindrome 'x'.
    // The maximum value for x is sqrt(10^18) = 10^9.
    // If x has 9 digits (e.g., 999,999,999), its first half (for odd length palindrome) is 5 digits (e.g., 99999).
    // So 'i' goes up to 99999. A loop up to 100000 is safe; the break condition handles the upper limit.
    for (let i = 1; i <= 100000; i++) {
        const s = i.toString();
        const reversed_s = s.split('').reverse().join('');

        // 1. Generate odd length palindrome 'x_odd'
        // Example: i = "123" -> x_odd = "12321"
        const p_odd_str = s + reversed_s.substring(1);
        const p_odd = BigInt(p_odd_str);
        const sq_odd = p_odd * p_odd;

        // If the square of the odd-length palindrome (which is generally smaller or equal to even-length for same 'i')
        // exceeds R, then all subsequent palindromes (from larger 'i' or potentially even length for current 'i')
        // will also exceed R. So we can break the loop early.
        if (sq_odd > R_big) {
            break;
        }
        if (sq_odd >= L_big && isPalindrome(sq_odd.toString())) {
            count++;
        }

        // 2. Generate even length palindrome 'x_even'
        // Example: i = "123" -> x_even = "123321"
        const p_even_str = s + reversed_s;
        const p_even = BigInt(p_even_str);
        const sq_even = p_even * p_even;

        // If the square of the even-length palindrome exceeds R, we don't count it.
        // We don't break the 'i' loop here because the odd-length palindrome for the next 'i'
        // might still be within range, though the `sq_odd > R_big` check above will eventually terminate the loop.
        if (sq_even > R_big) {
            // Skip checking this square, but continue to the next 'i' if the loop hasn't broken yet.
            continue; 
        }
        if (sq_even >= L_big && isPalindrome(sq_even.toString())) {
            count++;
        }
    }

    return count;
};
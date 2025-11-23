class Solution {
    public String subStrHash(String s, int power, int modulo, int k, int hashValue) {
        int n = s.length();

        // Calculate power^(k-1) % modulo, which is needed for the rolling hash.
        // This term is used when adding the new rightmost character to the window.
        long pk_minus_1 = pow(power, k - 1, modulo);

        // Calculate modular inverse of 'power'.
        // Since 'modulo' is prime, power_inv = power^(modulo-2) % modulo (by Fermat's Little Theorem).
        // This is used when dividing by 'power' in the rolling hash.
        long p_inv = pow(power, modulo - 2, modulo);

        long currentHash = 0;

        // Calculate the hash for the first window: s[0...k-1]
        // The hash definition is: (s[0]*p^0 + s[1]*p^1 + ... + s[k-1]*p^(k-1)) mod m
        long current_p_power = 1; // Represents p^0, p^1, p^2, ...
        for (int i = 0; i < k; i++) {
            // Convert character to its value (a=1, b=2, ..., z=26)
            long char_val = (s.charAt(i) - 'a' + 1);
            currentHash = (currentHash + char_val * current_p_power) % modulo;
            current_p_power = (current_p_power * power) % modulo; // Prepare for the next character's power
        }

        int ans_start_index = -1;

        // Check if the hash of the first window matches the target hashValue
        if (currentHash == hashValue) {
            ans_start_index = 0;
        }

        // Iterate through subsequent windows using a rolling hash approach
        // The window slides from s[i-1...i+k-2] to s[i...i+k-1]
        // Let H_old be the hash for s[i-1...i+k-2]
        // Let H_new be the hash for s[i...i+k-1]
        // The rolling hash formula for this specific hash definition is:
        // H_new = ( (H_old - val(s[i-1]) * p^0) * p_inv + val(s[i+k-1]) * p^(k-1) ) % modulo
        for (int i = 1; i <= n - k; i++) {
            // 1. Remove the contribution of the leftmost character of the previous window (s[i-1])
            //    val(s[i-1]) * p^0 is simply val(s[i-1])
            long char_to_remove_val = (s.charAt(i - 1) - 'a' + 1);
            currentHash = (currentHash - char_to_remove_val + modulo) % modulo; // Add modulo to ensure positive result

            // 2. Divide by 'power' to shift all remaining powers down by one
            currentHash = (currentHash * p_inv) % modulo;

            // 3. Add the contribution of the new rightmost character (s[i+k-1])
            //    This character is at position (k-1) within the new window, so it gets power^(k-1)
            long char_to_add_val = (s.charAt(i + k - 1) - 'a' + 1);
            currentHash = (currentHash + char_to_add_val * pk_minus_1) % modulo;

            // Check if the current window's hash matches the target hashValue
            if (currentHash == hashValue) {
                ans_start_index = i;
                break; // Found the first substring, so we can stop
            }
        }

        // Return the substring starting at the found index
        return s.substring(ans_start_index, ans_start_index + k);
    }

    // Modular exponentiation function: calculates (base^exp) % mod
    private long pow(long base, long exp, long mod) {
        long res = 1;
        base %= mod; // Ensure base is within modulo range
        while (exp > 0) {
            if (exp % 2 == 1) { // If exp is odd, multiply res by base
                res = (res * base) % mod;
            }
            base = (base * base) % mod; // Square the base
            exp /= 2; // Halve the exponent
        }
        return res;
    }
}
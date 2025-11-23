int countDigitOne(int n) {
    if (n < 0) {
        return 0;
    }

    int count = 0;
    long long pow10 = 1; // Represents 10^k for the current digit place

    while (pow10 <= n) {
        // Calculate parts of n relative to the current place value (pow10)
        // For example, if n = 345 and pow10 = 10 (tens place):
        // divisor = 100
        // a = 345 / 100 = 3 (the part before the tens digit, i.e., hundreds and thousands)
        // b = 345 % 10 = 5 (the part after the tens digit, i.e., units)
        // current_digit = (345 / 10) % 10 = 4 (the tens digit itself)

        long long divisor = pow10 * 10;
        long long a = n / divisor; 
        long long b = n % pow10;   
        int current_digit = (n / pow10) % 10; 

        if (current_digit == 0) {
            // If the current digit is 0, the number of '1's at this place value
            // is determined solely by the higher-order digits (a).
            // For example, if n=305, pow10=10 (tens place), a=3.
            // We count '1's in 010-019, 110-119, 210-219. This is a * pow10 = 3 * 10 = 30.
            count += a * pow10;
        } else if (current_digit == 1) {
            // If the current digit is 1, the number of '1's at this place value
            // is determined by higher-order digits (a) plus the remaining part (b) + 1.
            // For example, if n=315, pow10=10 (tens place), a=3, b=5.
            // We count '1's in 010-019, 110-119, 210-219 (a * pow10 = 30).
            // And also '1's in 310, 311, ..., 315 (b + 1 = 5 + 1 = 6).
            count += a * pow10 + b + 1;
        } else { // current_digit > 1
            // If the current digit is greater than 1, the number of '1's at this place value
            // is determined by the higher-order digits (a) plus one full block of pow10.
            // For example, if n=345, pow10=10 (tens place), a=3.
            // We count '1's in 010-019, 110-119, 210-219, 310-319. This is (a + 1) * pow10 = (3 + 1) * 10 = 40.
            count += (a + 1) * pow10;
        }

        // Prevent pow10 * 10 from overflowing if pow10 is already very large
        // and also serves as a loop termination condition if pow10 becomes too large
        // to be a valid place value within n.
        if (pow10 > n / 10) { 
            break;
        }
        pow10 *= 10;
    }
    return count;
}
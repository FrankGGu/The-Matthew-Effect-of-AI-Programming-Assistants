class Solution {
public:
    int smallestValue(int n) {
        while (true) {
            int next_n = 0;
            int temp_n = n; 

            // Handle factor 2
            while (temp_n > 1 && temp_n % 2 == 0) {
                next_n += 2;
                temp_n /= 2;
            }

            // Handle odd factors
            // Loop up to sqrt(temp_n)
            for (int i = 3; i * i <= temp_n; i += 2) {
                while (temp_n % i == 0) {
                    next_n += i;
                    temp_n /= i;
                }
            }

            // If temp_n is still greater than 1, it means the remaining temp_n is a prime factor itself
            if (temp_n > 1) {
                next_n += temp_n;
            }

            // Check for stabilization: if the number hasn't changed, we've found the smallest value
            if (next_n == n) {
                return n;
            }

            // Update n for the next iteration
            n = next_n;
        }
    }
};
long long kMirror(int k, int n) {
    long long sum = 0;
    int count = 0;
    long long num = 1;

    while (count < n) {
        // Check if num is palindrome in base 10
        long long temp = num;
        long long rev = 0;
        while (temp > 0) {
            rev = rev * 10 + temp % 10;
            temp /= 10;
        }
        if (rev != num) {
            num++;
            continue;
        }

        // Convert to base k and check if palindrome
        long long baseK[100];
        int len = 0;
        temp = num;
        while (temp > 0) {
            baseK[len++] = temp % k;
            temp /= k;
        }

        int isPalindrome = 1;
        for (int i = 0; i < len / 2; i++) {
            if (baseK[i] != baseK[len - 1 - i]) {
                isPalindrome = 0;
                break;
            }
        }

        if (isPalindrome) {
            sum += num;
            count++;
        }
        num++;
    }

    return sum;
}
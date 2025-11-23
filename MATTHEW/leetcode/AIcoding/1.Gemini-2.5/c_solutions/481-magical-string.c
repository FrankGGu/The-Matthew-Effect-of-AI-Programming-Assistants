int magicalString(int n) {
    if (n == 0) {
        return 0;
    }
    if (n <= 3) {
        return 1;
    }

    // s[0] = 1, s[1] = 2, s[2] = 2
    // The string can grow up to n characters.
    // The maximum n is 10^5, so allocate slightly more.
    char s[100001]; 
    s[0] = 1;
    s[1] = 2;
    s[2] = 2;

    int head = 2; // Pointer to the current number in s that dictates group length
    int tail = 3; // Pointer to the next position to fill in s
    int num_ones = 1; // Count of '1's in the string (s[0] is '1')

    while (tail < n) {
        // The character to append is the opposite of the last character appended
        char current_char_to_append = (s[tail - 1] == 1) ? 2 : 1;
        // The count of times to append is given by s[head]
        int count = s[head];

        for (int i = 0; i < count; i++) {
            if (tail < n) {
                s[tail] = current_char_to_append;
                if (current_char_to_append == 1) {
                    num_ones++;
                }
                tail++;
            } else {
                // Reached n characters, stop appending
                break;
            }
        }
        head++;
    }

    return num_ones;
}
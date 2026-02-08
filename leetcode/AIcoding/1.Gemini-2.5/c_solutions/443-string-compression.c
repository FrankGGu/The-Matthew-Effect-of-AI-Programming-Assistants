int compress(char* chars, int charsSize) {
    if (charsSize == 0) {
        return 0;
    }

    int write_ptr = 0;
    int read_ptr = 0;

    while (read_ptr < charsSize) {
        char current_char = chars[read_ptr];
        int count = 0;
        int look_ahead_ptr = read_ptr;

        // Count consecutive repeating characters
        while (look_ahead_ptr < charsSize && chars[look_ahead_ptr] == current_char) {
            count++;
            look_ahead_ptr++;
        }

        // Write the character
        chars[write_ptr++] = current_char;

        // If count is greater than 1, write its digits
        if (count > 1) {
            int start_digit_write_idx = write_ptr;
            int temp_count = count;

            // Extract digits in reverse order
            while (temp_count > 0) {
                chars[write_ptr++] = (temp_count % 10) + '0';
                temp_count /= 10;
            }

            // Reverse the digits to get the correct order
            int left = start_digit_write_idx;
            int right = write_ptr - 1;
            while (left < right) {
                char temp = chars[left];
                chars[left] = chars[right];
                chars[right] = temp;
                left++;
                right--;
            }
        }

        // Move read_ptr to the start of the next distinct character group
        read_ptr = look_ahead_ptr;
    }

    return write_ptr;
}
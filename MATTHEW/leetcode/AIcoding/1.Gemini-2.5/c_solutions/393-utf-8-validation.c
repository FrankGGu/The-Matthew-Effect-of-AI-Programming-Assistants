#include <stdbool.h>

bool validUtf8(int* data, int dataSize) {
    int num_bytes_to_follow = 0;

    for (int i = 0; i < dataSize; ++i) {
        int byte = data[i];

        if (num_bytes_to_follow == 0) {
            // This byte should be the start of a new UTF-8 character
            if ((byte & 0x80) == 0x00) {
                // 1-byte character: 0xxxxxxx
                // No bytes to follow
            } else if ((byte & 0xE0) == 0xC0) {
                // 2-byte character: 110xxxxx
                num_bytes_to_follow = 1;
            } else if ((byte & 0xF0) == 0xE0) {
                // 3-byte character: 1110xxxx
                num_bytes_to_follow = 2;
            } else if ((byte & 0xF8) == 0xF0) {
                // 4-byte character: 11110xxx
                num_bytes_to_follow = 3;
            } else {
                // Invalid start byte pattern (e.g., 10xxxxxx, 11111xxx, etc.)
                return false;
            }
        } else {
            // This byte should be a continuation byte: 10xxxxxx
            if ((byte & 0xC0) == 0x80) {
                num_bytes_to_follow--;
            } else {
                // Invalid continuation byte pattern
                return false;
            }
        }
    }

    // After iterating through all bytes, if num_bytes_to_follow is 0,
    // it means all multi-byte characters were correctly formed and completed.
    // If it's not 0, it means a multi-byte sequence was started but not completed.
    return num_bytes_to_follow == 0;
}
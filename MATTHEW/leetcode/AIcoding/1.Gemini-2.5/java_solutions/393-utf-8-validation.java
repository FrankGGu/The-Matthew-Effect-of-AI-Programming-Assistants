class Solution {
    public boolean isValidUtf8(int[] data) {
        int expectedContinuationBytes = 0;

        for (int currentByte : data) {
            if (expectedContinuationBytes == 0) {
                // This byte should be a start byte
                if ((currentByte & 0x80) == 0x00) {
                    // 1-byte character: 0xxxxxxx
                    expectedContinuationBytes = 0;
                } else if ((currentByte & 0xE0) == 0xC0) {
                    // 2-byte character: 110xxxxx
                    expectedContinuationBytes = 1;
                } else if ((currentByte & 0xF0) == 0xE0) {
                    // 3-byte character: 1110xxxx
                    expectedContinuationBytes = 2;
                } else if ((currentByte & 0xF8) == 0xF0) {
                    // 4-byte character: 11110xxx
                    expectedContinuationBytes = 3;
                } else {
                    // Invalid start byte (e.g., 10xxxxxx, 11111xxx, etc.)
                    return false;
                }
            } else {
                // This byte should be a continuation byte (10xxxxxx)
                if ((currentByte & 0xC0) == 0x80) {
                    expectedContinuationBytes--;
                } else {
                    // Invalid continuation byte
                    return false;
                }
            }
        }

        // If expectedContinuationBytes is 0 at the end, all characters were valid and complete.
        return expectedContinuationBytes == 0;
    }
}
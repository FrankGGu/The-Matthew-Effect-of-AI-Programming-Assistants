class Solution {
    public String decodeAtIndex(String S, long K) {
        long currentLength = 0;

        // Step 1: Calculate the total length of the decoded string.
        // Cap currentLength at Long.MAX_VALUE if it overflows,
        // as any value larger than K will behave the same for K % N
        // until N drops below K during the backward pass.
        for (char c : S.toCharArray()) {
            if (Character.isDigit(c)) {
                int digit = c - '0';
                // Check for potential overflow before multiplication
                // If currentLength * digit would exceed Long.MAX_VALUE, cap it.
                if (currentLength > Long.MAX_VALUE / digit) {
                    currentLength = Long.MAX_VALUE;
                } else {
                    currentLength *= digit;
                }
            } else {
                // If currentLength is already at MAX_VALUE, adding 1 would overflow or stay MAX_VALUE.
                // We keep it at MAX_VALUE as it's effectively "infinite" relative to K.
                if (currentLength < Long.MAX_VALUE) {
                    currentLength++;
                }
            }
        }

        // Step 2: Iterate backwards through S to find the K-th character.
        for (int i = S.length() - 1; i >= 0; i--) {
            char c = S.charAt(i);

            // Adjust K to be within the current segment's length.
            // K is 1-indexed. K % currentLength handles wrapping.
            // If K becomes 0 after modulo, it means it's the last character of the segment.
            K %= currentLength;
            if (K == 0) {
                K = currentLength;
            }

            if (Character.isDigit(c)) {
                // If it's a digit, the current segment was formed by repeating a previous segment.
                // The length of the previous segment was currentLength / (c - '0').
                // We adjust currentLength to this previous segment's length.
                currentLength /= (c - '0');
            } else {
                // If it's a letter, the current segment was formed by appending this letter.
                // If K matches the current currentLength (meaning it's the last character of this segment),
                // then this letter is our answer.
                if (K == currentLength) {
                    return String.valueOf(c);
                }
                // Otherwise, this letter is not the one we're looking for,
                // and we decrement currentLength to consider the string without this letter.
                // currentLength will always be > 0 here, so no underflow concern.
                currentLength--;
            }
        }

        // This line should theoretically not be reached given problem constraints
        // and the guarantee that K is valid.
        return "";
    }
}
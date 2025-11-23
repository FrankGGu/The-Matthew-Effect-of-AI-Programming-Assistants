class Solution {
    public int[] threeEqualParts(int[] arr) {
        int totalOnes = 0;
        for (int x : arr) {
            totalOnes += x;
        }

        if (totalOnes == 0) {
            // If all zeros, any valid split works.
            // The problem requires 0 <= i < j < arr.length.
            // For arr.length >= 3, [0, arr.length - 2] is a valid split.
            // Part1: arr[0] (value 0)
            // Part2: arr[1 ... arr.length - 2] (value 0)
            // Part3: arr[arr.length - 1] (value 0)
            return new int[]{0, arr.length - 2};
        }

        if (totalOnes % 3 != 0) {
            return new int[]{-1, -1};
        }

        int onesPerPart = totalOnes / 3;

        // Find the start index of the first '1' for each logical part.
        // p1_start: index of the 1st '1'
        // p2_start: index of the (onesPerPart + 1)-th '1'
        // p3_start: index of the (2 * onesPerPart + 1)-th '1'
        int p1_start = -1, p2_start = -1, p3_start = -1;

        int currentOneCount = 0;
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == 1) {
                currentOneCount++;
                if (currentOneCount == 1) p1_start = i;
                if (currentOneCount == onesPerPart + 1) p2_start = i;
                if (currentOneCount == 2 * onesPerPart + 1) p3_start = i;
            }
        }

        // The length of the effective binary number (from its first '1' to the end of the array)
        // is determined by the third part, as it has no elements after it.
        int len_effective_part = arr.length - p3_start;

        // Compare the three effective parts.
        // These are:
        // arr[p1_start ... p1_start + len_effective_part - 1]
        // arr[p2_start ... p2_start + len_effective_part - 1]
        // arr[p3_start ... arr.length - 1]
        for (int k = 0; k < len_effective_part; k++) {
            if (arr[p1_start + k] != arr[p2_start + k] || arr[p1_start + k] != arr[p3_start + k]) {
                return new int[]{-1, -1};
            }
        }

        // Calculate the split points i and j.
        // i is the last index of the first part.
        // j is the last index of the second part.
        // The first part must be identical to the effective third part, so it ends at:
        // p1_start + (len_effective_part - 1)
        // The second part must be identical to the effective third part, so it ends at:
        // p2_start + (len_effective_part - 1)
        int i = p1_start + len_effective_part - 1;
        int j = p2_start + len_effective_part - 1;

        // Final sanity check for i and j bounds: 0 <= i < j < arr.length.
        // i < j is guaranteed because p1_start < p2_start (since onesPerPart > 0).
        // j < arr.length is guaranteed because p2_start < p3_start, which implies
        // p2_start + len_effective_part - 1 < p3_start + len_effective_part - 1
        // which simplifies to p2_start + arr.length - p3_start - 1 < arr.length - 1,
        // and further to p2_start - p3_start < 0, which is true.
        // Also, j must be strictly less than arr.length - 1 to allow for a non-empty third part.
        // This is also guaranteed since p2_start < p3_start.

        return new int[]{i, j};
    }
}
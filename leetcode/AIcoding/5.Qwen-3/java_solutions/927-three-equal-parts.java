public class Solution {
    public int[] threeEqualParts(int[] arr) {
        int n = arr.length;
        int[] count = new int[n];
        int totalOnes = 0;
        for (int i = 0; i < n; i++) {
            if (arr[i] == 1) {
                totalOnes++;
            }
            count[i] = totalOnes;
        }
        if (totalOnes % 3 != 0) {
            return new int[]{-1, -1};
        }
        if (totalOnes == 0) {
            return new int[]{0, 2};
        }
        int part = totalOnes / 3;
        int first = -1, second = -1, third = -1;
        for (int i = 0; i < n; i++) {
            if (arr[i] == 1) {
                if (count[i] == part) {
                    first = i;
                } else if (count[i] == 2 * part) {
                    second = i;
                } else if (count[i] == 3 * part) {
                    third = i;
                }
            }
        }
        int len = n - third;
        if (first + len > second || second + len > third) {
            return new int[]{-1, -1};
        }
        return new int[]{first + len, second + len};
    }
}
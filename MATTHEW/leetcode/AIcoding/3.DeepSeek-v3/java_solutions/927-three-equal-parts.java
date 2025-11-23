class Solution {
    public int[] threeEqualParts(int[] arr) {
        int countOnes = 0;
        for (int num : arr) {
            if (num == 1) {
                countOnes++;
            }
        }
        if (countOnes == 0) {
            return new int[]{0, arr.length - 1};
        }
        if (countOnes % 3 != 0) {
            return new int[]{-1, -1};
        }
        int k = countOnes / 3;
        int first = -1, second = -1, third = -1;
        int cnt = 0;
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == 1) {
                cnt++;
                if (cnt == 1) {
                    first = i;
                } else if (cnt == k + 1) {
                    second = i;
                } else if (cnt == 2 * k + 1) {
                    third = i;
                }
            }
        }
        while (third < arr.length) {
            if (arr[first] == arr[second] && arr[second] == arr[third]) {
                first++;
                second++;
                third++;
            } else {
                return new int[]{-1, -1};
            }
        }
        return new int[]{first - 1, second};
    }
}
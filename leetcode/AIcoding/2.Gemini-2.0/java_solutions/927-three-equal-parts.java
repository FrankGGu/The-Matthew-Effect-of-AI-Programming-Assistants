class Solution {
    public int[] threeEqualParts(int[] arr) {
        int ones = 0;
        for (int a : arr) {
            ones += a;
        }
        if (ones % 3 != 0) {
            return new int[]{-1, -1};
        }
        if (ones == 0) {
            return new int[]{0, 2};
        }

        int target = ones / 3;
        int first = -1, second = -1, third = -1, count = 0;
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == 1) {
                count++;
                if (count == 1) {
                    first = i;
                } else if (count == target + 1) {
                    second = i;
                } else if (count == 2 * target + 1) {
                    third = i;
                }
            }
        }

        while (third < arr.length) {
            if (arr[first] != arr[second] || arr[second] != arr[third]) {
                return new int[]{-1, -1};
            }
            first++;
            second++;
            third++;
        }

        return new int[]{first - 1, second};
    }
}
class Solution {
    public int[] threeEqualParts(int[] arr) {
        int totalOnes = 0;
        for (int num : arr) {
            totalOnes += num;
        }

        if (totalOnes == 0) return new int[]{0, 2};
        if (totalOnes % 3 != 0) return new int[]{-1, -1};

        int onesPerPart = totalOnes / 3;
        int first = -1, second = -1, third = -1;
        int count = 0;

        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == 1) {
                count++;
                if (count == 1) first = i;
                else if (count == onesPerPart + 1) second = i;
                else if (count == 2 * onesPerPart + 1) third = i;
            }
        }

        while (third < arr.length && arr[first] == arr[second] && arr[second] == arr[third]) {
            first++;
            second++;
            third++;
        }

        return third == arr.length ? new int[]{first - 1, second} : new int[]{-1, -1};
    }
}
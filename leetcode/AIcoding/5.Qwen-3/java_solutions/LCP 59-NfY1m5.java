public class Solution {
    public int minTimeToCross(int[] leftBank, int[] rightBank, int boatCapacity) {
        int time = 0;
        int leftCount = leftBank.length;
        int rightCount = rightBank.length;
        int[] left = new int[leftCount];
        int[] right = new int[rightCount];
        System.arraycopy(leftBank, 0, left, 0, leftCount);
        System.arraycopy(rightBank, 0, right, 0, rightCount);

        while (true) {
            int[] leftSorted = sortArray(left);
            int[] rightSorted = sortArray(right);

            if (leftSorted.length == 0 && rightSorted.length == 0) {
                return time;
            }

            if (leftSorted.length > 0 && rightSorted.length == 0) {
                if (leftSorted.length == 1) {
                    time += leftSorted[0];
                    left = removeElement(left, leftSorted[0]);
                    break;
                } else {
                    time += leftSorted[0] + leftSorted[1];
                    left = removeElement(left, leftSorted[0]);
                    left = removeElement(left, leftSorted[1]);
                }
            } else if (rightSorted.length > 0 && leftSorted.length == 0) {
                if (rightSorted.length == 1) {
                    time += rightSorted[0];
                    right = removeElement(right, rightSorted[0]);
                    break;
                } else {
                    time += rightSorted[0] + rightSorted[1];
                    right = removeElement(right, rightSorted[0]);
                    right = removeElement(right, rightSorted[1]);
                }
            } else {
                if (leftSorted[0] <= rightSorted[0]) {
                    time += leftSorted[0];
                    left = removeElement(left, leftSorted[0]);
                } else {
                    time += rightSorted[0];
                    right = removeElement(right, rightSorted[0]);
                }
            }
        }
    }

    private int[] sortArray(int[] arr) {
        int[] sorted = new int[arr.length];
        for (int i = 0; i < arr.length; i++) {
            sorted[i] = arr[i];
        }
        java.util.Arrays.sort(sorted);
        return sorted;
    }

    private int[] removeElement(int[] arr, int value) {
        int count = 0;
        for (int num : arr) {
            if (num == value) {
                count++;
            }
        }
        int[] result = new int[arr.length - count];
        int index = 0;
        for (int num : arr) {
            if (num != value) {
                result[index++] = num;
            }
        }
        return result;
    }
}
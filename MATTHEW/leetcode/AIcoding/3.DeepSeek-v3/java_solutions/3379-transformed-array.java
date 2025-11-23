class Solution {
    public int[] transformArray(int[] arr) {
        if (arr.length <= 2) {
            return arr;
        }
        boolean changed;
        int[] newArr = new int[arr.length];
        System.arraycopy(arr, 0, newArr, 0, arr.length);
        do {
            changed = false;
            for (int i = 1; i < arr.length - 1; i++) {
                if (arr[i] > arr[i - 1] && arr[i] > arr[i + 1]) {
                    newArr[i]--;
                    changed = true;
                } else if (arr[i] < arr[i - 1] && arr[i] < arr[i + 1]) {
                    newArr[i]++;
                    changed = true;
                }
            }
            int[] temp = arr;
            arr = newArr;
            newArr = temp;
        } while (changed);
        return arr;
    }
}
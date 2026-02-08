class Solution {
    public boolean isMagic(int[] target) {
        int n = target.length;
        int[] original = new int[n];
        for (int i = 0; i < n; i++) {
            original[i] = i + 1;
        }
        int k = findK(original, target);
        if (k == 0) {
            return false;
        }
        return simulate(original, target, k);
    }

    private int findK(int[] original, int[] target) {
        int n = original.length;
        int[] temp = original.clone();
        int k = 0;
        while (true) {
            shuffle(temp);
            int count = 0;
            for (int i = 0; i < n && i < temp.length; i++) {
                if (temp[i] == target[i]) {
                    count++;
                } else {
                    break;
                }
            }
            if (count == 0) {
                break;
            }
            if (k < count) {
                k = count;
            }
            temp = Arrays.copyOfRange(temp, count, temp.length);
            if (temp.length == 0) {
                break;
            }
        }
        return k;
    }

    private void shuffle(int[] arr) {
        List<Integer> odd = new ArrayList<>();
        List<Integer> even = new ArrayList<>();
        for (int i = 0; i < arr.length; i++) {
            if (i % 2 == 1) {
                odd.add(arr[i]);
            } else {
                even.add(arr[i]);
            }
        }
        odd.addAll(even);
        for (int i = 0; i < arr.length; i++) {
            arr[i] = odd.get(i);
        }
    }

    private boolean simulate(int[] original, int[] target, int k) {
        int n = original.length;
        int[] arr = original.clone();
        int[] result = new int[n];
        int index = 0;
        while (arr.length > 0) {
            shuffle(arr);
            int take = Math.min(k, arr.length);
            for (int i = 0; i < take; i++) {
                result[index++] = arr[i];
            }
            arr = Arrays.copyOfRange(arr, take, arr.length);
        }
        for (int i = 0; i < n; i++) {
            if (result[i] != target[i]) {
                return false;
            }
        }
        return true;
    }
}
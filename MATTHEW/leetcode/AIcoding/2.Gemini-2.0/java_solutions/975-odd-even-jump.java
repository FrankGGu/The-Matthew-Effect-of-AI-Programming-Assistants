class Solution {
    public int oddEvenJumps(int[] arr) {
        int n = arr.length;
        boolean[] odd = new boolean[n];
        boolean[] even = new boolean[n];
        odd[n - 1] = even[n - 1] = true;
        int ans = 1;

        for (int i = n - 2; i >= 0; i--) {
            int oddNext = -1;
            int evenNext = -1;

            int minDiff = Integer.MAX_VALUE;
            for (int j = i + 1; j < n; j++) {
                if (arr[j] >= arr[i] && arr[j] - arr[i] <= minDiff) {
                    if (arr[j] - arr[i] < minDiff) {
                        minDiff = arr[j] - arr[i];
                        oddNext = j;
                    } else {
                        oddNext = (oddNext == -1 || arr[j] < arr[oddNext]) ? j : oddNext;
                    }
                }
            }

            int maxDiff = Integer.MAX_VALUE;
            for (int j = i + 1; j < n; j++) {
                if (arr[j] <= arr[i] && arr[i] - arr[j] <= maxDiff) {
                    if (arr[i] - arr[j] < maxDiff) {
                        maxDiff = arr[i] - arr[j];
                        evenNext = j;
                    } else {
                        evenNext = (evenNext == -1 || arr[j] > arr[evenNext]) ? j : evenNext;
                    }
                }
            }

            if (oddNext != -1) {
                odd[i] = even[oddNext];
                if (odd[i]) {
                    ans++;
                }
            }

            if (evenNext != -1) {
                even[i] = odd[evenNext];
            }
        }

        return ans;
    }
}
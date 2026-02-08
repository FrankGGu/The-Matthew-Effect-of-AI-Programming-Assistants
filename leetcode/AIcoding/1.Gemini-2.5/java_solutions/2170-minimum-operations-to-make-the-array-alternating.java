class Solution {
    public int minimumOperations(int[] nums) {
        int n = nums.length;
        if (n <= 1) {
            return 0;
        }

        int[] evenCounts = new int[100001];
        int[] oddCounts = new int[100001];

        int nEven = (n + 1) / 2;
        int nOdd = n / 2;

        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                evenCounts[nums[i]]++;
            } else {
                oddCounts[nums[i]]++;
            }
        }

        int evenMax1Val = -1, evenMax1Count = 0;
        int evenMax2Val = -1, evenMax2Count = 0;

        for (int i = 1; i <= 100000; i++) {
            if (evenCounts[i] > evenMax1Count) {
                evenMax2Count = evenMax1Count;
                evenMax2Val = evenMax1Val;
                evenMax1Count = evenCounts[i];
                evenMax1Val = i;
            } else if (evenCounts[i] > evenMax2Count) {
                evenMax2Count = evenCounts[i];
                evenMax2Val = i;
            }
        }

        int oddMax1Val = -1, oddMax1Count = 0;
        int oddMax2Val = -1, oddMax2Count = 0;

        for (int i = 1; i <= 100000; i++) {
            if (oddCounts[i] > oddMax1Count) {
                oddMax2Count = oddMax1Count;
                oddMax2Val = oddMax1Val;
                oddMax1Count = oddCounts[i];
                oddMax1Val = i;
            } else if (oddCounts[i] > oddMax2Count) {
                oddMax2Count = oddCounts[i];
                oddMax2Val = i;
            }
        }

        int minOperations;

        if (evenMax1Val != oddMax1Val) {
            minOperations = (nEven - evenMax1Count) + (nOdd - oddMax1Count);
        } else {
            int opsA = (nEven - evenMax1Count) + (nOdd - oddMax2Count);
            int opsB = (nEven - evenMax2Count) + (nOdd - oddMax1Count);
            minOperations = Math.min(opsA, opsB);
        }

        return minOperations;
    }
}
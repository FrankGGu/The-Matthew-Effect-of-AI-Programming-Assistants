import java.util.Arrays;

class FenwickTree {
    private int[] bit;
    private int size;

    public FenwickTree(int size) {
        this.size = size;
        bit = new int[size + 1];
    }

    public void update(int idx, int val) {
        idx++;
        while (idx <= size) {
            bit[idx] += val;
            idx += idx & (-idx);
        }
    }

    public int query(int idx) {
        if (idx < 0) return 0;
        idx++;
        int sum = 0;
        while (idx > 0) {
            sum += bit[idx];
            idx -= idx & (-idx);
        }
        return sum;
    }
}

class Pair implements Comparable<Pair> {
    int value;
    int originalIndex;

    Pair(int value, int originalIndex) {
        this.value = value;
        this.originalIndex = originalIndex;
    }

    @Override
    public int compareTo(Pair other) {
        if (this.value != other.value) {
            return Integer.compare(this.value, other.value);
        }
        return Integer.compare(this.originalIndex, other.originalIndex);
    }
}

class Solution {
    public long makeArrayEmpty(int[] nums) {
        int n = nums.length;
        Pair[] pairs = new Pair[n];
        for (int i = 0; i < n; i++) {
            pairs[i] = new Pair(nums[i], i);
        }

        Arrays.sort(pairs);

        FenwickTree ft = new FenwickTree(n);
        for (int i = 0; i < n; i++) {
            ft.update(i, 1);
        }

        long totalCost = 0;

        for (int i = 0; i < n; i++) {
            Pair currentPair = pairs[i];
            int originalIndex = currentPair.originalIndex;

            int currentActualIndex = ft.query(originalIndex - 1);
            totalCost += currentActualIndex;

            ft.update(originalIndex, -1);
        }

        return totalCost;
    }
}
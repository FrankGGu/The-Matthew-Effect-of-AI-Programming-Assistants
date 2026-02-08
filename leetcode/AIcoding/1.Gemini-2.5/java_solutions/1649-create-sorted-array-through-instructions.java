class FenwickTree {
    private int[] tree;
    private int size;

    public FenwickTree(int size) {
        this.size = size;
        tree = new int[size + 1]; // Fenwick tree is 1-indexed
    }

    // Adds delta to the element at the given index
    public void update(int index, int delta) {
        while (index <= size) {
            tree[index] += delta;
            index += index & (-index); // Move to the next parent
        }
    }

    // Returns the sum of elements from 1 to the given index
    public int query(int index) {
        int sum = 0;
        while (index > 0) {
            sum += tree[index];
            index -= index & (-index); // Move to the previous parent
        }
        return sum;
    }
}

class Solution {
    public int createSortedArray(int[] instructions) {
        int MAX_VAL = 100000; 
        FenwickTree ft = new FenwickTree(MAX_VAL);
        long totalCost = 0;
        long MOD = 1_000_000_007;

        for (int i = 0; i < instructions.length; i++) {
            int num = instructions[i];

            // Count elements strictly less than num
            // This is the sum of frequencies from 1 to num-1
            long leftCount = ft.query(num - 1);

            // Count elements strictly greater than num
            // Total elements processed so far is 'i' (0-indexed loop)
            // Elements less than or equal to num is ft.query(num)
            // So, elements strictly greater than num = (total elements processed) - (elements <= num)
            long rightCount = i - ft.query(num);

            totalCost = (totalCost + Math.min(leftCount, rightCount)) % MOD;

            // Add the current number to the Fenwick tree
            ft.update(num, 1);
        }

        return (int) totalCost;
    }
}
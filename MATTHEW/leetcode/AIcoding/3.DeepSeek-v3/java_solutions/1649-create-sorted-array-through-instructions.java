class Solution {
    private int[] tree;
    private int size;

    public int createSortedArray(int[] instructions) {
        int max = 0;
        for (int num : instructions) {
            max = Math.max(max, num);
        }
        size = max + 2;
        tree = new int[size];
        long cost = 0;
        for (int i = 0; i < instructions.length; i++) {
            int num = instructions[i];
            int less = query(num - 1);
            int greater = i - query(num);
            cost += Math.min(less, greater);
            update(num);
        }
        return (int) (cost % 1_000_000_007);
    }

    private void update(int index) {
        while (index < size) {
            tree[index]++;
            index += index & -index;
        }
    }

    private int query(int index) {
        int sum = 0;
        while (index > 0) {
            sum += tree[index];
            index -= index & -index;
        }
        return sum;
    }
}
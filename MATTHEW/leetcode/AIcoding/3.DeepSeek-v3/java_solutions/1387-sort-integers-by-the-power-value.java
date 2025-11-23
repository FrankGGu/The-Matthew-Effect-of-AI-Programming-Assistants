class Solution {
    public int getKth(int lo, int hi, int k) {
        List<int[]> list = new ArrayList<>();
        for (int i = lo; i <= hi; i++) {
            list.add(new int[]{i, getPower(i)});
        }
        Collections.sort(list, (a, b) -> {
            if (a[1] == b[1]) {
                return a[0] - b[0];
            } else {
                return a[1] - b[1];
            }
        });
        return list.get(k - 1)[0];
    }

    private int getPower(int x) {
        int steps = 0;
        while (x != 1) {
            if (x % 2 == 0) {
                x /= 2;
            } else {
                x = 3 * x + 1;
            }
            steps++;
        }
        return steps;
    }
}
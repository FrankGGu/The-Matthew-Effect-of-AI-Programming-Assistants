class Solution {
    public double[] getCollisionTimes(int[][] cars) {
        int n = cars.length;
        double[] res = new double[n];
        Arrays.fill(res, -1.0);
        Deque<Integer> stack = new ArrayDeque<>();

        for (int i = n - 1; i >= 0; --i) {
            while (!stack.isEmpty()) {
                int j = stack.peek();
                if (cars[i][1] <= cars[j][1]) {
                    stack.pop();
                } else {
                    double time = (double)(cars[j][0] - cars[i][0]) / (cars[i][1] - cars[j][1]);
                    if (res[j] == -1 || time <= res[j]) {
                        res[i] = time;
                        break;
                    } else {
                        stack.pop();
                    }
                }
            }
            stack.push(i);
        }
        return res;
    }
}
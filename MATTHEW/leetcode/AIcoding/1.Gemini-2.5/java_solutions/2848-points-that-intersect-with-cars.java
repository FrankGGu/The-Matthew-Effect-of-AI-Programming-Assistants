import java.util.List;

class Solution {
    public int numberOfPoints(List<List<Integer>> cars) {
        boolean[] coveredPoints = new boolean[101]; // Points are from 1 to 100

        for (List<Integer> car : cars) {
            int start = car.get(0);
            int end = car.get(1);
            for (int i = start; i <= end; i++) {
                coveredPoints[i] = true;
            }
        }

        int count = 0;
        for (int i = 1; i <= 100; i++) {
            if (coveredPoints[i]) {
                count++;
            }
        }

        return count;
    }
}
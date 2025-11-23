import java.util.ArrayList;
import java.util.List;

class Solution {
    public int calPoints(String[] operations) {
        List<Integer> scores = new ArrayList<>();
        for (String op : operations) {
            if (op.equals("+")) {
                int lastScore = scores.get(scores.size() - 1);
                int secondLastScore = scores.get(scores.size() - 2);
                scores.add(lastScore + secondLastScore);
            } else if (op.equals("D")) {
                int lastScore = scores.get(scores.size() - 1);
                scores.add(2 * lastScore);
            } else if (op.equals("C")) {
                scores.remove(scores.size() - 1);
            } else {
                scores.add(Integer.parseInt(op));
            }
        }

        int totalSum = 0;
        for (int score : scores) {
            totalSum += score;
        }
        return totalSum;
    }
}
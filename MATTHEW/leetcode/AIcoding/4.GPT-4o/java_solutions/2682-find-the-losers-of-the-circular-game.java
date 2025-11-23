import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> findTheLosers(int n, int k) {
        boolean[] eliminated = new boolean[n];
        int count = 0, index = 0;

        while (count < n - 1) {
            int step = 0;
            while (step < k) {
                if (!eliminated[index]) {
                    step++;
                }
                index = (index + 1) % n;
            }
            eliminated[(index - 1 + n) % n] = true;
            count++;
        }

        List<Integer> losers = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (!eliminated[i]) {
                losers.add(i + 1);
            }
        }
        return losers;
    }
}
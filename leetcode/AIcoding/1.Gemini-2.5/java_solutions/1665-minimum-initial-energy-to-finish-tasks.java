import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public long minimumEffort(int[][] tasks) {
        Arrays.sort(tasks, new Comparator<int[]>() {
            @Override
            public int compare(int[] t1, int[] t2) {
                return (t2[1] - t2[0]) - (t1[1] - t1[0]);
            }
        });

        long initialEnergy = 0;
        long currentEnergy = 0;

        for (int[] task : tasks) {
            int actual = task[0];
            int minimum = task[1];

            if (currentEnergy < minimum) {
                initialEnergy += (minimum - currentEnergy);
                currentEnergy = minimum;
            }

            currentEnergy -= actual;
        }

        return initialEnergy;
    }
}
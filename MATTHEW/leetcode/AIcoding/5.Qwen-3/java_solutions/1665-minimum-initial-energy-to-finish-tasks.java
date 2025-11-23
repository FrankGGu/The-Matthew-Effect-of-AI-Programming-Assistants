public class Solution {

import java.util.*;

class Solution {
    public int minInitialEnergy(int[][] tasks) {
        List<int[]> taskList = new ArrayList<>(Arrays.asList(tasks));
        taskList.sort((a, b) -> (a[0] - b[0]) - (a[1] - b[1]));
        int energy = 0;
        for (int[] task : taskList) {
            energy += task[0] - task[1];
            if (energy < 0) {
                energy = 0;
            }
        }
        return energy + 1;
    }
}
}
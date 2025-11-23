import java.util.Arrays;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] prisonCellsAfterNDays(int[] cells, int n) {
        if (n == 0) {
            return cells;
        }

        HashMap<Integer, Integer> seenStates = new HashMap<>();
        List<int[]> stateHistory = new ArrayList<>();

        int currentDay = 0;
        int[] currentCells = Arrays.copyOf(cells, 8);

        while (n > 0) {
            int stateInt = 0;
            for (int i = 0; i < 8; i++) {
                if (currentCells[i] == 1) {
                    stateInt |= (1 << i);
                }
            }

            if (seenStates.containsKey(stateInt)) {
                int prevDay = seenStates.get(stateInt);
                int cycleLength = currentDay - prevDay;
                int remainingDays = n;
                int finalStateIndexInHistory = prevDay + (remainingDays % cycleLength);
                return stateHistory.get(finalStateIndexInHistory);
            }

            seenStates.put(stateInt, currentDay);
            stateHistory.add(Arrays.copyOf(currentCells, 8));

            int[] nextCells = new int[8];
            nextCells[0] = 0;
            nextCells[7] = 0;
            for (int i = 1; i < 7; i++) {
                nextCells[i] = (currentCells[i - 1] == currentCells[i + 1]) ? 1 : 0;
            }
            currentCells = nextCells;
            n--;
            currentDay++;
        }

        return currentCells;
    }
}
public class Solution {

import java.util.*;

public class Solution {
    private Map<Integer, Integer> rankMap;
    private TreeSet<Integer> sortedRanks;

    public Solution() {
        rankMap = new HashMap<>();
        sortedRanks = new TreeSet<>();
    }

    public int[] query(int rank) {
        int count = 0;
        for (int r : sortedRanks) {
            if (r < rank) {
                count += rankMap.get(r);
            } else {
                break;
            }
        }
        return new int[]{count + 1, rankMap.get(rank)};
    }

    public void insert(int rank) {
        rankMap.put(rank, rankMap.getOrDefault(rank, 0) + 1);
        sortedRanks.add(rank);
    }

    public void remove(int rank) {
        rankMap.put(rank, rankMap.get(rank) - 1);
        if (rankMap.get(rank) == 0) {
            rankMap.remove(rank);
            sortedRanks.remove(rank);
        }
    }
}
}
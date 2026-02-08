public class Solution {

import java.util.*;

public class TopVotedCandidate {
    private int[] time;
    private int[] lead;

    public TopVotedCandidate(int[] persons, int[] times) {
        time = times;
        Map<Integer, Integer> count = new HashMap<>();
        int max = 0;
        lead = new int[persons.length];
        for (int i = 0; i < persons.length; i++) {
            count.put(persons[i], count.getOrDefault(persons[i], 0) + 1);
            if (count.get(persons[i]) >= max) {
                max = count.get(persons[i]);
                lead[i] = persons[i];
            } else {
                lead[i] = lead[i - 1];
            }
        }
    }

    public int q(int t) {
        int left = 0, right = time.length - 1;
        while (left < right) {
            int mid = (left + right) / 2;
            if (time[mid] <= t) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return lead[left];
    }
}
}
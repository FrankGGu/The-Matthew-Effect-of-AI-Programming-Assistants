import java.util.*;

class TopVotedCandidate {
    private List<Integer> candidates;
    private List<Integer> times;

    public TopVotedCandidate(int[] persons, int[] times) {
        this.candidates = new ArrayList<>();
        this.times = new ArrayList<>();
        Map<Integer, Integer> countMap = new HashMap<>();
        int maxVotes = 0;
        int winner = -1;

        for (int i = 0; i < persons.length; i++) {
            int person = persons[i];
            countMap.put(person, countMap.getOrDefault(person, 0) + 1);
            if (countMap.get(person) >= maxVotes) {
                maxVotes = countMap.get(person);
                winner = person;
            }
            candidates.add(winner);
            this.times.add(times[i]);
        }
    }

    public int q(int t) {
        int left = 0, right = times.size() - 1;
        while (left < right) {
            int mid = left + (right - left + 1) / 2;
            if (times.get(mid) <= t) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return candidates.get(left);
    }
}
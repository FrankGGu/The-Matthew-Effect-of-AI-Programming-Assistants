import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class TopVotedCandidate {

    private List<Integer> recordedTimes;
    private List<Integer> leadersAtTime;

    public TopVotedCandidate(int[] persons, int[] times) {
        recordedTimes = new ArrayList<>();
        leadersAtTime = new ArrayList<>();

        Map<Integer, Integer> voteCounts = new HashMap<>();
        int currentLeader = -1;
        int maxVotes = 0;

        for (int i = 0; i < persons.length; i++) {
            int person = persons[i];
            int time = times[i];

            voteCounts.put(person, voteCounts.getOrDefault(person, 0) + 1);

            if (voteCounts.get(person) >= maxVotes) {
                maxVotes = voteCounts.get(person);
                currentLeader = person;
            }

            recordedTimes.add(time);
            leadersAtTime.add(currentLeader);
        }
    }

    public int query(int t) {
        int index = Collections.binarySearch(recordedTimes, t);

        if (index < 0) {
            index = -(index + 1) - 1;
        }

        return leadersAtTime.get(index);
    }
}